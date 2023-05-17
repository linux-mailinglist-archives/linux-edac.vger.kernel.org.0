Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE32705FEE
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjEQGYs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjEQGYi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 02:24:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3A230FA
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:24:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf21bb427so3508985ad.1
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304676; x=1686896676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K67aK8Ab6zSc42er2APhm2wp24bW0xcr3MHHlTQF0Aw=;
        b=PLmqcsERKtayg5W2hORcES8w46jOP+ssRMKTy4UsUZDidL5h58nTE6sAn+ExLP0YPa
         SVdWkOD6bCZAX0svoUFO6oePSa30dR1SbrsfhR3JfnVP/Fi+ulVFd5IKUcn1BlxPxXEL
         tqER/wGSPHh1ICMlQnejuqtiU/KzORgJYmk6WpHvcT8bHLI4NLJya1KzICz+g8urDMkb
         knoVJWyABCX1gVzwwxh9aka6gJguMQKeg+vsRO0cTAebbNn/vD16kIttMGz+EeO843oJ
         KPWJgWrS4nupHN8mxOLTRu6s8bsB6fN6eE/KU7X8WJmqM8ONhDTjtHbXQ3cRqnqDzYm+
         79bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304676; x=1686896676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K67aK8Ab6zSc42er2APhm2wp24bW0xcr3MHHlTQF0Aw=;
        b=XElwXSO4fhh2dxe6snOpPr00XENfUz27ckL8kFmU+LQQN9do6iqNRyATvsuYqPnaQ2
         Bd0nQh4ddIisamlMRQT0FfOqYkAfjv2hMmPinoC0ly/yfUeJuv7EzGNBXKUUh7qP/MPX
         BBbpEzdTWMGGq3vhH40KiG5lEmcT5BM8VVxm5O3LYHF9B6LEeR3qzk0I4M+2A11jRvbk
         POCmEnX0CfhNZRvmCXh2jafggZd3awak7xlQ9wAUNsZz95K70dpnDljUlMVksR1pUYQw
         qoh4ecytr6EiF5SMG52Lb8jO8+8zq0vrPLAlFSmWk7SwUaASGGZtN0+fLdrkH9zCj5KJ
         ec8g==
X-Gm-Message-State: AC+VfDwqIRjZIISWMmVRF6bYwmokFkomB/JHbfwewqfBhZ9CCYzq8UJi
        9wpNIo0YoUSNuqPMsZkaVOZcTTzoUdhUXn4sHA==
X-Google-Smtp-Source: ACHHUZ5zgJp/SqjIxAupLZpWqTbjlKLwG/oRYoxz+bVGVLkCqIjkI+7ngWv32jtJ86utkoQrCjNvzA==
X-Received: by 2002:a17:903:185:b0:1aa:db0f:1aba with SMTP id z5-20020a170903018500b001aadb0f1abamr48265536plg.47.1684304676540;
        Tue, 16 May 2023 23:24:36 -0700 (PDT)
Received: from localhost.localdomain ([59.92.102.59])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090acb1600b002508f0ac3edsm693282pjt.53.2023.05.16.23.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 23:24:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7] dt-bindings: leds: Document commonly used LED triggers
Date:   Wed, 17 May 2023 11:54:20 +0530
Message-Id: <20230517062421.56970-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517062421.56970-1-manivannan.sadhasivam@linaro.org>
References: <20230517062421.56970-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Document the commonly used LED triggers by the SoCs. Not all triggers
are documented as some of them are very application specific. Most of the
triggers documented here are currently used in devicetrees of many SoCs.

While at it, add missing comments and also place the comment above the
triggers (hci, mmc, wlan) to match the rest of the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v7:

* Rebased on top of next/master

Changes in v6:

* Rebased on top of lee/for-leds-next branch
* Fixed the comment location for few triggers

Changes in v5:

* Rebased on top of v6.2-rc1

Changes in v4:

* Removed the sorting of triggers
* Removed the "items" as they were not needed
* Reworded the description
* Dropped Zhen Lei's tested-by tag as the patch has changed
* Added kbd-capslock trigger

Changes in v3:

* Rebased on top of v6.1-rc1
* Added WLAN Rx trigger
* Added tested tag from Zhen Lei

Changes in v2:

* Added more triggers, fixed the regex
* Sorted triggers in ascending order

 .../devicetree/bindings/leds/common.yaml      | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 15e3f6645682..61e63ed81ced 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -90,22 +90,49 @@ properties:
           - heartbeat
             # LED indicates disk activity
           - disk-activity
+            # LED indicates disk read activity
           - disk-read
+            # LED indicates disk write activity
           - disk-write
             # LED flashes at a fixed, configurable rate
           - timer
             # LED alters the brightness for the specified duration with one software
             # timer (requires "led-pattern" property)
           - pattern
+            # LED indicates mic mute state
+          - audio-micmute
+            # LED indicates audio mute state
+          - audio-mute
+            # LED indicates bluetooth power state
+          - bluetooth-power
+            # LED indicates activity of all CPUs
+          - cpu
+            # LED indicates camera flash state
+          - flash
+            # LED indicated keyboard capslock
+          - kbd-capslock
+            # LED indicates MTD memory activity
+          - mtd
+            # LED indicates NAND memory activity (deprecated),
+            # in new implementations use "mtd"
+          - nand-disk
+            # No trigger assigned to the LED. This is the default mode
+            # if trigger is absent
+          - none
+            # LED indicates camera torch state
+          - torch
+            # LED indicates USB gadget activity
           - usb-gadget
+            # LED indicates USB host activity
           - usb-host
+        # LED is triggered by CPU activity
       - pattern: "^cpu[0-9]*$"
-      - pattern: "^hci[0-9]+-power$"
         # LED is triggered by Bluetooth activity
-      - pattern: "^mmc[0-9]+$"
+      - pattern: "^hci[0-9]+-power$"
         # LED is triggered by SD/MMC activity
-      - pattern: "^phy[0-9]+tx$"
+      - pattern: "^mmc[0-9]+$"
         # LED is triggered by WLAN activity
+      - pattern: "^phy[0-9]+tx$"
 
   led-pattern:
     description: |
-- 
2.25.1

