Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AF86720A4
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjARPJi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 10:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjARPJV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 10:09:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C931E5FD
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a184so26405546pfa.9
        for <linux-edac@vger.kernel.org>; Wed, 18 Jan 2023 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b3A1ENOut7aNsWCrE1p0bbYMaJf6g4gCfGrBW3niiU=;
        b=V0GP2xZ9ALQYbIs2LpKz6ECcKJ0MwWRBh+9tbtdCd69NptGSqFuVgnCHV6YB3wnpcS
         Ed4f0BxPWm19o496hKKuim/EzFn0+HVy31f4wVz1JbLRVw6wAgA4t/o+fidVDwn5TJO8
         S5i8dxfc8PolN013w5Vza0OsMLzqhRD/kd9NE32WHFrbj7JBlFfWJ6LEja8cHUCw5oKK
         kl2Rq9EWsPy8u1s5Ok5LBK01d7Txsy+Ue6ahfFK7M26noXN8L0OVCxszE9sfOJ7iB1/g
         Ac3KKs+4TNRxLrq7WylSVABz0FipAs6S7Z6vN070gKKBNuaGiD/A2gbwWd5k7NLmoFEr
         Uazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b3A1ENOut7aNsWCrE1p0bbYMaJf6g4gCfGrBW3niiU=;
        b=L533Trswy23c22SnlGoYwL+BOV7U52GyFjdjGpqtPq0N+bVA4oatNE0RcH81Wofuu6
         Xvq+p3vNHTIfpl3x3sB73x/YqGjjS13VEDZeBNcRP1ALJmu6s9HerODGphpqhAlOvOuy
         LHV1S4qAM4zURA2uvUprzIZAnzebrgk+Vr5ymTMRw8gZJTOv+ozJoO8oZZTKHLB9o+IU
         kyGLjvg4nkXM5wxHfcdSqh9jCnYfMle60AFxIZid9HBaEvO4UcFsjbd/cqxjxjUwmJhI
         dGZ1uvQ3Psr6s5el1+o4Yi9fKCKd2oHKcuZZHea2S0i38rrPUkg0ZDniA2F12AlZChJK
         7MBw==
X-Gm-Message-State: AFqh2kqNi1gbHut8hjP5XPHDE3IXwtUh0Q44ca8FHOB8M6kCGdYJM545
        P/3o0qnQ2PgqzZ7Ef+lfxYJ9
X-Google-Smtp-Source: AMrXdXsLTWywF4NbchUpZhySfS8ietOm7jmmeDUYkw4BmqGHBpj3Pb/+0uYWijxasklhMlDHCZX1FQ==
X-Received: by 2002:aa7:8d11:0:b0:587:f436:6ea8 with SMTP id j17-20020aa78d11000000b00587f4366ea8mr6651438pfe.16.1674054559488;
        Wed, 18 Jan 2023 07:09:19 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v6 01/17] EDAC/device: Respect any driver-supplied workqueue polling value
Date:   Wed, 18 Jan 2023 20:38:48 +0530
Message-Id: <20230118150904.26913-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The EDAC drivers may optionally pass the poll_msec value. Use that value
if available, else fall back to 1000ms.

  [ bp: Touchups. ]

Fixes: e27e3dac6517 ("drivers/edac: add edac_device class")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Cc: <stable@vger.kernel.org> # 4.9
Link: https://lore.kernel.org/r/COZYL8MWN97H.MROQ391BGA09@otso
---
 drivers/edac/edac_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 19522c568aa5..a50b7bcfb731 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -34,6 +34,9 @@
 static DEFINE_MUTEX(device_ctls_mutex);
 static LIST_HEAD(edac_device_list);
 
+/* Default workqueue processing interval on this instance, in msecs */
+#define DEFAULT_POLL_INTERVAL 1000
+
 #ifdef CONFIG_EDAC_DEBUG
 static void edac_device_dump_device(struct edac_device_ctl_info *edac_dev)
 {
@@ -336,7 +339,7 @@ static void edac_device_workq_function(struct work_struct *work_req)
 	 * whole one second to save timers firing all over the period
 	 * between integral seconds
 	 */
-	if (edac_dev->poll_msec == 1000)
+	if (edac_dev->poll_msec == DEFAULT_POLL_INTERVAL)
 		edac_queue_work(&edac_dev->work, round_jiffies_relative(edac_dev->delay));
 	else
 		edac_queue_work(&edac_dev->work, edac_dev->delay);
@@ -366,7 +369,7 @@ static void edac_device_workq_setup(struct edac_device_ctl_info *edac_dev,
 	 * timers firing on sub-second basis, while they are happy
 	 * to fire together on the 1 second exactly
 	 */
-	if (edac_dev->poll_msec == 1000)
+	if (edac_dev->poll_msec == DEFAULT_POLL_INTERVAL)
 		edac_queue_work(&edac_dev->work, round_jiffies_relative(edac_dev->delay));
 	else
 		edac_queue_work(&edac_dev->work, edac_dev->delay);
@@ -398,7 +401,7 @@ void edac_device_reset_delay_period(struct edac_device_ctl_info *edac_dev,
 {
 	unsigned long jiffs = msecs_to_jiffies(value);
 
-	if (value == 1000)
+	if (value == DEFAULT_POLL_INTERVAL)
 		jiffs = round_jiffies_relative(value);
 
 	edac_dev->poll_msec = value;
@@ -443,11 +446,7 @@ int edac_device_add_device(struct edac_device_ctl_info *edac_dev)
 		/* This instance is NOW RUNNING */
 		edac_dev->op_state = OP_RUNNING_POLL;
 
-		/*
-		 * enable workq processing on this instance,
-		 * default = 1000 msec
-		 */
-		edac_device_workq_setup(edac_dev, 1000);
+		edac_device_workq_setup(edac_dev, edac_dev->poll_msec ?: DEFAULT_POLL_INTERVAL);
 	} else {
 		edac_dev->op_state = OP_RUNNING_INTERRUPT;
 	}
-- 
2.25.1

