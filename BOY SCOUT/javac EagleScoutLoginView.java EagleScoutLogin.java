import javax.swing.*;
import java.awt.*;

public class EagleScoutLoginView extends JPanel {
    JTextField emailField;
    JPasswordField passwordField;
    JButton signInButton;

    public EagleScoutLoginView() {
        setLayout(null);

        // Logo
        JLabel logoLabel;
        ImageIcon logoIcon = new ImageIcon("eagle_scout_logo.png");
        if (logoIcon.getIconWidth() == -1) {
            logoLabel = new JLabel("Logo");
            logoLabel.setHorizontalAlignment(SwingConstants.CENTER);
            logoLabel.setBorder(BorderFactory.createLineBorder(Color.GRAY));
        } else {
            logoLabel = new JLabel(logoIcon);
        }
        logoLabel.setBounds(140, 30, 100, 100);
        add(logoLabel);

        // Title
        JLabel titleLabel = new JLabel("<html><center>National Eagle Scout Association<br>of the Philippines</center></html>", SwingConstants.CENTER);
        titleLabel.setBounds(20, 140, 350, 40);
        titleLabel.setFont(new Font("Arial", Font.BOLD, 14));
        add(titleLabel);

        // Email Label and Field
        JLabel emailLabel = new JLabel("Email / Serial Number:");
        emailLabel.setBounds(50, 200, 300, 20);
        add(emailLabel);

        emailField = new JTextField();
        emailField.setBounds(50, 225, 300, 30);
        add(emailField);

        // Password Label and Field
        JLabel passwordLabel = new JLabel("Password:");
        passwordLabel.setBounds(50, 270, 300, 20);
        add(passwordLabel);

        passwordField = new JPasswordField();
        passwordField.setBounds(50, 295, 300, 30);
        add(passwordField);

        // Sign In Button
        signInButton = new JButton("Sign In");
        signInButton.setBounds(140, 350, 120, 35);
        add(signInButton);

        // Footer
        JLabel footer = new JLabel("\u201cLaging Handa\u201d", SwingConstants.CENTER);
        footer.setBounds(100, 500, 200, 30);
        footer.setFont(new Font("Serif", Font.ITALIC, 16));
        add(footer);
    }
}