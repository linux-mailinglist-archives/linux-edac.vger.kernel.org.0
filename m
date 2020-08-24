Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42F524FE08
	for <lists+linux-edac@lfdr.de>; Mon, 24 Aug 2020 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgHXMtn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Aug 2020 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMtk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Aug 2020 08:49:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B91C061573;
        Mon, 24 Aug 2020 05:49:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so9445233ljn.11;
        Mon, 24 Aug 2020 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EhT2u43kcx6UjD668AKXzHx6F4jOPNWF9dfqVX6UIw8=;
        b=aWP0g1bNBLQjMKEh8u2lU3vTEEHC3s0t7EKsIJE+ldcJsLnU6btCKoXW1hJ4eA5MMF
         j9izKmWhtJTJyRqgFBSPySp53i6NIP0MGkN2d0YuVvPAclZVmvj8jnakPN+4yly0Tc8j
         FKuJr4ZFx0X2UoBN3i7Ai7Ij0qmNVBwl51bzAGhd/sidtMGiaSp76QwNGUwFoVqeuO3v
         YOawtDDR93WwLIktMLxzVgulxiB3QCKDADty+zlcRbQulUtDgaSLn/RAa0tdFwDRfack
         UolmflvnoQOnDRV1nb18BY7CZl97EyRK2/xTXwAdKc5bOtn867b30CTeqUseXdKc5C9/
         FEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=EhT2u43kcx6UjD668AKXzHx6F4jOPNWF9dfqVX6UIw8=;
        b=umjC6XGaYC/ILYfidEogeblIJH6VezFvpBHRfEjh0oUmZSISGFXcrN/piLWIUkFjzZ
         EZUO8Vq77O+F7kIT5PT7bFRmZG4nYPqtJayFI4LFQJI7YDFxkS5nrdTv2zeWVPFQqY8D
         kY5iMa167A+j/srFbwFCyLdDBKppWefRmbiWvoCteXy3MUcgRCSOpzzoaog0+KWCsEqD
         ay+5h9dJiTYLvpIso9n8izlEj+Cq7HK0F4czlZBBCB7PD/NrYH9nrqm+aOtFOE/P1A2j
         YtAo+ccV3GF/0nYBZXcWSBpI6/Ux2MK6X9m+p3kH9LpgyeMukC1BqtVC4LdFYMcuX3RQ
         IwJw==
X-Gm-Message-State: AOAM5307D5Eaxec5+5pdAOXZ9XkQsaS/qPFoiwDXgvliiQuDaICs9DMs
        0QztNvispk/CTYovFHtP8u4=
X-Google-Smtp-Source: ABdhPJxDLknDAWXF1+h5XCrwnjvYHZT8Yv8+sKbubBBys/sa6ZgczCgiM8xW3yn7fq882Gs6b7Ehew==
X-Received: by 2002:a2e:8e9a:: with SMTP id z26mr2390612ljk.271.1598273377743;
        Mon, 24 Aug 2020 05:49:37 -0700 (PDT)
Received: from rric.localhost (31-208-27-44.cust.bredband2.com. [31.208.27.44])
        by smtp.gmail.com with ESMTPSA id y16sm2180416ljg.21.2020.08.24.05.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:49:36 -0700 (PDT)
From:   Robert Richter <rric@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Richter <rric@kernel.org>
Subject: [PATCH] MAINTAINERS, edac: Calxeda Highbank, handover maintenance to Andre Przywara
Date:   Mon, 24 Aug 2020 14:49:31 +0200
Message-Id: <20200824124931.2933-1-rric@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I do not have hardware anymore, nor there is ongoing development. So
handover maintenance to Andre who already maintains the last
remainings of Calxeda.

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Robert Richter <rric@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b7b0c1a24c8..6ed56e1a7d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6148,7 +6148,7 @@ S:	Supported
 F:	drivers/edac/bluefield_edac.c
 
 EDAC-CALXEDA
-M:	Robert Richter <rric@kernel.org>
+M:	Andre Przywara <andre.przywara@arm.com>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/highbank*
-- 
2.20.1

