import React, { useState } from 'react';
import supabase from '../../utils/supabase/client';

const Auth = () => {
  const [isLogin, setIsLogin] = useState(true);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [formData, setFormData] = useState({
    username: '',
    scoutSerial: '',
    password: '',
    confirmPassword: ''
  });

  const handleInputChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
    // Clear error when user starts typing
    if (error) setError('');
  };

  const validateForm = () => {
    if (!formData.username.trim()) {
      setError('Username is required');
      return false;
    }
    if (!formData.scoutSerial.trim()) {
      setError('Scout Serial Number is required');
      return false;
    }
    if (!formData.password) {
      setError('Password is required');
      return false;
    }
    if (!isLogin && formData.password !== formData.confirmPassword) {
      setError('Passwords do not match');
      return false;
    }
    if (!isLogin && formData.password.length < 3) {
      setError('Password must be at least 3 characters long');
      return false;
    }
    return true;
  };

  const handleLogin = async () => {
    try {
      setLoading(true);
      setError('');

      // Create a simple email from username (more flexible)
      const email = formData.username.includes('@') 
        ? formData.username 
        : `${formData.username.toLowerCase()}@gmail.com`;

      // Sign in with Supabase Auth
      const { data, error: authError } = await supabase.auth.signInWithPassword({
        email: email,
        password: formData.password
      });

      if (authError) {
        throw authError;
      }

      // More flexible profile validation
      try {
        const { data: profileData, error: profileError } = await supabase
          .from('scouts')
          .select('scout_serial, username, id')
          .eq('username', formData.username.toLowerCase())
          .single();

        if (profileError || !profileData) {
          // If no profile found, create one from current form data
          const { error: insertError } = await supabase
            .from('scouts')
            .insert([
              {
                id: data.user.id,
                username: formData.username.toLowerCase(),
                scout_serial: formData.scoutSerial,
                email: email,
                created_at: new Date().toISOString()
              }
            ]);

          if (insertError) {
            console.log('Profile creation during login failed:', insertError);
            // Continue with login even if profile creation fails
          }
        } else {
          // Check if scout serial matches (case-insensitive)
          const storedSerial = profileData.scout_serial.toLowerCase();
          const inputSerial = formData.scoutSerial.toLowerCase();
          
          if (storedSerial !== inputSerial) {
            await supabase.auth.signOut();
            throw new Error('Scout serial number does not match records');
          }
        }
      } catch (profileError) {
        console.log('Profile validation error:', profileError);
        // Continue with login - don't fail on profile issues
      }

      // Get the JWT token
      const { data: { session } } = await supabase.auth.getSession();
      
      if (session?.access_token) {
        localStorage.setItem('bsp_token', session.access_token);
        localStorage.setItem('bsp_refresh_token', session.refresh_token);
        localStorage.setItem('bsp_username', formData.username);
        localStorage.setItem('bsp_scout_serial', formData.scoutSerial);
        
        console.log('Login successful:', {
          user: data.user,
          token: session.access_token
        });
        
        // Show success message
        setError('');
        alert('Login successful! Welcome back, ' + formData.username);
        
        // Clear form after successful login
        setFormData({
          username: '',
          scoutSerial: '',
          password: '',
          confirmPassword: ''
        });
      }

    } catch (error) {
      console.error('Login error:', error);
      if (error.message.includes('Invalid login credentials')) {
        setError('Invalid username or password. Please check your credentials.');
      } else {
        setError(error.message || 'Login failed. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleRegister = async () => {
    try {
      setLoading(true);
      setError('');

      // Create email from username (flexible format)
      const email = formData.username.includes('@') 
        ? formData.username 
        : `${formData.username.toLowerCase()}@gmail.com`;

      // Sign up with Supabase Auth
      const { data, error: authError } = await supabase.auth.signUp({
        email: email,
        password: formData.password,
        options: {
          data: {
            username: formData.username.toLowerCase(),
            scout_serial: formData.scoutSerial
          }
        }
      });

      if (authError) {
        throw authError;
      }

      // Wait a moment for the user to be created
      await new Promise(resolve => setTimeout(resolve, 500));

      // Try to create scout profile
      try {
        const { error: profileError } = await supabase
          .from('scouts')
          .insert([
            {
              id: data.user.id,
              username: formData.username.toLowerCase(),
              scout_serial: formData.scoutSerial,
              email: email,
              created_at: new Date().toISOString()
            }
          ]);

        if (profileError) {
          console.log('Profile creation error:', profileError);
          // Continue with registration even if profile creation fails
        }
      } catch (profileError) {
        console.log('Profile creation failed, continuing with auth-only registration');
      }

      // Get the JWT token
      const { data: { session } } = await supabase.auth.getSession();
      
      if (session?.access_token) {
        localStorage.setItem('bsp_token', session.access_token);
        localStorage.setItem('bsp_refresh_token', session.refresh_token);
        localStorage.setItem('bsp_username', formData.username);
        localStorage.setItem('bsp_scout_serial', formData.scoutSerial);
        
        console.log('Registration successful:', {
          user: data.user,
          token: session.access_token
        });
        
        // Show success message
        setError('');
        alert('Registration successful! Welcome to BSP, ' + formData.username);
        
        // Clear form after successful registration
        setFormData({
          username: '',
          scoutSerial: '',
          password: '',
          confirmPassword: ''
        });
      }

    } catch (error) {
      console.error('Registration error:', error);
      if (error.message.includes('User already registered')) {
        setError('This username is already registered. Please try signing in instead.');
      } else if (error.message.includes('Password should be at least')) {
        setError('Password is too short. Please use at least 3 characters.');
      } else {
        setError(error.message || 'Registration failed. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!validateForm()) {
      return;
    }

    if (isLogin) {
      await handleLogin();
    } else {
      await handleRegister();
    }
  };

  const toggleMode = () => {
    setIsLogin(!isLogin);
    setError('');
    setFormData({
      username: '',
      scoutSerial: '',
      password: '',
      confirmPassword: ''
    });
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-100 via-purple-100 to-red-100 flex">
      {/* Left Side - BSP Branding */}
      <div className="w-1/3 bg-blue-800 relative flex">
        {/* Blue stripe */}
        <div className="w-1/3 bg-blue-800 flex flex-col items-center justify-center p-4">
          <div className="text-center text-white">
            <div className="w-20 h-20 mx-auto mb-4 bg-white rounded-full flex items-center justify-center">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-800 to-red-600 rounded-full flex items-center justify-center">
                <div className="text-white text-xs font-bold">BSP</div>
              </div>
            </div>
          </div>
        </div>

        {/* Yellow stripe */}
        <div className="w-1/3 bg-yellow-400 flex flex-col items-center justify-center">
          <div className="text-center">
            <div className="w-16 h-16 bg-yellow-500 rounded-full flex items-center justify-center mb-4">
              <div className="text-blue-900 text-xl">🦅</div>
            </div>
          </div>
        </div>

        {/* Red stripe */}
        <div className="w-1/3 bg-red-600 flex flex-col items-center justify-center p-4">
          <div className="text-center text-white">
            <div className="w-16 h-16 mx-auto mb-4 bg-yellow-400 rounded-full flex items-center justify-center">
              <div className="text-blue-900 text-xl font-bold">⚜️</div>
            </div>
            <p className="text-sm font-serif italic mb-1">On My Honor</p>
            <p className="text-xs font-serif italic">I Will Do My Best</p>
          </div>
        </div>
      </div>

      {/* Right Side - Login Form */}
      <div className="flex-1 bg-gradient-to-br from-gray-200 via-gray-100 to-gray-200 p-8 flex items-center justify-center relative">
        {/* Textured background overlay */}
        <div className="absolute inset-0 opacity-20 bg-gradient-to-br from-blue-200 to-red-200"></div>
        
        <div className="relative z-10 w-full max-w-md">
          <h2 className="text-4xl font-bold text-red-700 mb-8 text-center">
            Trail ahead
          </h2>
          
          {/* Toggle Login/Register */}
          <div className="flex mb-6 bg-gray-100 rounded-lg p-1">
            <button
              onClick={toggleMode}
              className={`flex-1 py-2 px-4 rounded-md text-sm font-medium transition-colors ${
                isLogin 
                  ? 'bg-blue-600 text-white shadow-sm' 
                  : 'text-gray-600 hover:text-gray-800'
              }`}
            >
              Sign In
            </button>
            <button
              onClick={toggleMode}
              className={`flex-1 py-2 px-4 rounded-md text-sm font-medium transition-colors ${
                !isLogin 
                  ? 'bg-blue-600 text-white shadow-sm' 
                  : 'text-gray-600 hover:text-gray-800'
              }`}
            >
              Register
            </button>
          </div>

          {/* Error Message */}
          {error && (
            <div className="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded">
              {error}
            </div>
          )}

          {/* Form Fields */}
          <div className="bg-white/70 backdrop-blur-sm p-6 rounded-lg border-2 border-gray-400 shadow-lg">
            <div className="space-y-4">
              {/* Username */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-2">
                  USERNAME:
                </label>
                <input
                  type="text"
                  name="username"
                  value={formData.username}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border-2 border-gray-800 bg-white focus:outline-none focus:border-blue-500"
                  disabled={loading}
                />
              </div>

              {/* Scout Serial Number */}
              <div>
                <label className="block text-sm font-medium text-gray-800 mb-2">
                  Scout Serial Number (any format)
                </label>
                <input
                  type="text"
                  name="scoutSerial"
                  value={formData.scoutSerial}
                  onChange={handleInputChange}
                  placeholder="e.g., 12345, BSP-001, or any format"
                  className="w-full px-3 py-2 border-2 border-gray-800 bg-white focus:outline-none focus:border-blue-500"
                  disabled={loading}
                />
              </div>

              {/* Password */}
              <div>
                <label className="block text-sm font-bold text-gray-800 mb-2">
                  PASSWORD:
                </label>
                <input
                  type="password"
                  name="password"
                  value={formData.password}
                  onChange={handleInputChange}
                  className="w-full px-3 py-2 border-2 border-gray-800 bg-white focus:outline-none focus:border-blue-500"
                  disabled={loading}
                />
              </div>

              {/* Confirm Password (Register only) */}
              {!isLogin && (
                <div>
                  <label className="block text-sm font-bold text-gray-800 mb-2">
                    CONFIRM PASSWORD:
                  </label>
                  <input
                    type="password"
                    name="confirmPassword"
                    value={formData.confirmPassword}
                    onChange={handleInputChange}
                    className="w-full px-3 py-2 border-2 border-gray-800 bg-white focus:outline-none focus:border-blue-500"
                    disabled={loading}
                  />
                </div>
              )}
            </div>
          </div>

          {/* Submit Button */}
          <div className="mt-6 text-center">
            <button
              onClick={handleSubmit}
              disabled={loading}
              className="px-8 py-2 bg-white border-2 border-gray-800 text-gray-800 font-medium hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-500 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {loading ? 'Please wait...' : (isLogin ? 'Sign In' : 'Register')}
            </button>
          </div>

          {/* Additional Links */}
          {isLogin && (
            <div className="mt-6 text-center">
              <a href="#" className="text-sm text-blue-600 hover:text-blue-800 transition-colors">
                Forgot your password?
              </a>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Auth;

