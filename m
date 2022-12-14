Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4A64C19C
	for <lists+linux-edac@lfdr.de>; Wed, 14 Dec 2022 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiLNBDo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Dec 2022 20:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiLNBDn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Dec 2022 20:03:43 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7E19C35;
        Tue, 13 Dec 2022 17:03:42 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id i2so16485819vsc.1;
        Tue, 13 Dec 2022 17:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGrvT4OV0InN5SJsTwsJ4Wj96hMY1O01ImoY2ZUC2Fs=;
        b=dWolur7TyaFyhOKFqEIiBlqm2oFvcqupqAq53wPf4AEGToG9nNnGNOlGg8yjlJNpfJ
         0nKNQ7AySPWilWXr3c0XcxngKTYFjLfmfotvMwjCW94vc9+Ekz7Xdd78BJNsdqA6Rgsl
         /c6kiW5aA2xZx6GQSLGhAY/PbGwFQ3T0Lt68DmyZrahNTvghn69XvOKUeNcjIhcKgvog
         4eG8zFZ7FIyI2mdygW0N7Y+KSt9jnoni79vBqJ2c/MIKHimfS8/wv5AAGTZ85YSPHmKA
         CRBJSFHugg4MpCV3ByAts8BeJwcnydbQuk3+Qtx5MJJNX4cxLqY18u7lUZFofZ0MgSMw
         RjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGrvT4OV0InN5SJsTwsJ4Wj96hMY1O01ImoY2ZUC2Fs=;
        b=kzC9QK9NVyiMo0KGqGQAWf0Pbs6jyJt+62PMaAovPV8u8TnQMS13lnMz68vxKGxb/2
         T6Bniiq0UXs5aj/oN9Dv60GLw6lbHDWSNJGtmoEqVp25MwfCEh+Tukms+GKVIr/ks5o5
         qjvYVa0+93uAwyqsi3oiN40q2ZyqQFt/6C48F3rnB5kHoIb6Sy2bVVh27/K+B5gHpz3D
         /e4P22hA1uOGFAhvDiwYkDp0criTbi3OlKp7xiU3aY6e6Yj7PE2P3nWfqyjsgWAEtFSr
         3MY3fiwcRqGzVaxJDcl3pxXwlISwtmqLLttFwlvWkAj1avdbUHvrFyQJjbnFXDxB85pQ
         1tCg==
X-Gm-Message-State: ANoB5pmsH3nXVDK2M76xXJ6u8ibLAp9XgnbJEm0QxFfWbNXhw+GTje+Z
        EKXJRumH+nIKFf+wXZlEsg==
X-Google-Smtp-Source: AA0mqf7CPdAi9hC17KPupxvN+AYZqoaPD4l4n0eWDN7VN70EfmI1uWBWNtpBQNpqEfGs8TYa/TfxFg==
X-Received: by 2002:a67:ea0d:0:b0:3aa:1298:ca2 with SMTP id g13-20020a67ea0d000000b003aa12980ca2mr12161019vso.28.1670979821580;
        Tue, 13 Dec 2022 17:03:41 -0800 (PST)
Received: from ?IPV6:2603:7080:a33a:d95d:20:71fc:7eaf:858a? (2603-7080-a33a-d95d-0020-71fc-7eaf-858a.res6.spectrum.com. [2603:7080:a33a:d95d:20:71fc:7eaf:858a])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a0f1300b006e16dcf99c8sm8976662qkl.71.2022.12.13.17.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 17:03:41 -0800 (PST)
Message-ID: <fee7bcaa-f7d3-0457-9c55-c88b2ffa7da1@gmail.com>
Date:   Tue, 13 Dec 2022 20:03:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Content-Language: en-US
To:     ardb@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, mchehab@kernel.org, rric@kernel.org,
        robert.moore@intel.com, qiuxu.zhuo@intel.com,
        yazen.ghannam@amd.com, jlu@pengutronix.de
Cc:     khuong@os.amperecomputing.com, toshi.kani@hpe.com,
        justin.he@arm.com, James Morse <james.morse@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org
From:   Seija Kijin <doremylover123@gmail.com>
Subject: [PATCH] drivers: correct parameters passed to strncmp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Many times when strncmp is called with the intent of ignoring the NULL terminator, the null terminator is accidentally included in that comparison, which in practice is just an strcmp with extra steps.

Subtract from the places where the intent seems to be to do a comparison without the NULL terminator.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
  arch/arm/mach-omap2/sr_device.c                 | 8 ++++----
  drivers/edac/amd64_edac.c                       | 2 +-
  drivers/edac/i10nm_base.c                       | 2 +-
  drivers/edac/igen6_edac.c                       | 2 +-
  drivers/edac/pnd2_edac.c                        | 2 +-
  drivers/edac/sb_edac.c                          | 2 +-
  drivers/edac/skx_base.c                         | 2 +-
  drivers/media/pci/bt8xx/bttv-cards.c            | 2 +-
  drivers/net/ethernet/cavium/liquidio/lio_main.c | 2 +-
  drivers/staging/nvec/nvec_power.c               | 2 +-
  10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index db672cf19a51..883f3078e233 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -94,12 +94,12 @@ static int __init sr_init_by_name(const char *name, const char *voltdm)
      struct omap_volt_data *volt_data;
      static int i;

-    if (!strncmp(name, "smartreflex_mpu_iva", 20) ||
-        !strncmp(name, "smartreflex_mpu", 16))
+    if (!strncmp(name, "smartreflex_mpu_iva", 19) ||
+        !strncmp(name, "smartreflex_mpu", 15))
          sr_data = &omap_sr_pdata[OMAP_SR_MPU];
-    else if (!strncmp(name, "smartreflex_core", 17))
+    else if (!strncmp(name, "smartreflex_core", 16))
          sr_data = &omap_sr_pdata[OMAP_SR_CORE];
-    else if (!strncmp(name, "smartreflex_iva", 16))
+    else if (!strncmp(name, "smartreflex_iva", 15))
          sr_data = &omap_sr_pdata[OMAP_SR_IVA];

      if (!sr_data) {
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e3318e5575a3..1d832f484f8d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4333,7 +4333,7 @@ static int __init amd64_edac_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      if (!x86_match_cpu(amd64_cpuids))
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 65aeea53e2df..546dd9fc5cc5 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -759,7 +759,7 @@ static int __init i10nm_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 544dd19072ea..7df2b3a82221 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1275,7 +1275,7 @@ static int __init igen6_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      edac_op_state = EDAC_OPSTATE_NMI;
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 2b306f2cc605..08aeab382cb4 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1532,7 +1532,7 @@ static int __init pnd2_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 0c779a0326b6..6f8904b55213 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3638,7 +3638,7 @@ static int __init sbridge_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 9397abb42c49..ea38449710f5 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -657,7 +657,7 @@ static int __init skx_init(void)
          return -EBUSY;

      owner = edac_get_owner();
-    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
+    if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR) - 1))
          return -EBUSY;

      if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
diff --git a/drivers/media/pci/bt8xx/bttv-cards.c b/drivers/media/pci/bt8xx/bttv-cards.c
index c2b5ab287dd7..c24cc2f46d2f 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -2968,7 +2968,7 @@ static void identify_by_eeprom(struct bttv *btv, unsigned char eeprom_data[256])

      if (0 == strncmp(eeprom_data,"GET MM20xPCTV",13))
          type = BTTV_BOARD_MODTEC_205;
-    else if (0 == strncmp(eeprom_data+20,"Picolo",7))
+    else if (0 == strncmp(eeprom_data + 20, "Picolo", 6))
          type = BTTV_BOARD_EURESYS_PICOLO;
      else if (eeprom_data[0] == 0x84 && eeprom_data[2]== 0)
          type = BTTV_BOARD_HAUPPAUGE; /* old bt848 */
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index fd7c80edb6e8..549ea559463b 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -912,7 +912,7 @@ liquidio_probe(struct pci_dev *pdev, const struct pci_device_id __maybe_unused *
  static bool fw_type_is_auto(void)
  {
      return strncmp(fw_type, LIO_FW_NAME_TYPE_AUTO,
-               sizeof(LIO_FW_NAME_TYPE_AUTO)) == 0;
+               sizeof(LIO_FW_NAME_TYPE_AUTO) - 1) == 0;
  }

  /**
diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index b1ef196e1cfe..3ed9e06e32de 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -207,7 +207,7 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
           * This differs a little from the spec fill in more if you find
           * some.
           */
-        if (!strncmp(power->bat_type, "Li", 30))
+        if (!strncmp(power->bat_type, "Li", 2))
              power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_LION;
          else
              power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-- 
2.38.2


