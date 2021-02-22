Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60645321CB0
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBVQUi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhBVQUc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:20:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDCAC06174A;
        Mon, 22 Feb 2021 08:19:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so22782979edt.3;
        Mon, 22 Feb 2021 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QVBl/nog7ajTZyJooeSLMs7Y96NRWAigPOMqPEdzv6o=;
        b=cQDjY5GUWanhbS2OnAsCn20OlNIB06mIPJLPTBW3thWhwj6wHaBiuEnA+TF/uEib27
         3PMUQc/Wn8h39smKNq/QUZo79D4y1WkwlN2ysS57K2iW5sigGOCw94g3HDG5tg7d6t3u
         rbOZGqt845mDl2ZQxwoKLZELN+Jwq8l276XgcgkRwjyb6+JO99B/bZvEr6PXyClcJ+vd
         BwWyvAC/LyQyf2eDUXJXcgrIkaYm1MIHeTzj+N1+RimfSq90z4tWBvmCgVNJk24sXpxJ
         Yk9rDxiV1rwX0YXE+xUSi13luLVjBMt83qk7nzAHwfrNVV4F8kRCUSsv7ai4QScWCBWB
         pKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QVBl/nog7ajTZyJooeSLMs7Y96NRWAigPOMqPEdzv6o=;
        b=QrX6evxz7gXyFF6/SXpghB26h+Q7DiuRTVyOcBJA6dwWCm9H1LqpEE+boFEnoWuZtl
         VeKWrW92WbJUdesMS6s9EasSiRfFRCFcX9v9jFRoWZxgucKhhIm9tZkF9se5IZB8evit
         EURKp9S3GbTPTkJzequoldI8gV5KY9fZM3yM6fgstvfwbUR2PXR07FsOGFpN1CSwNi4h
         qHf5zri1/c24LICNwtndV2sx9O1ysnAd1JP74JsV6trAgDrKylxh05sV9JYqRQEw/x3Z
         iPFQkFba0MCNRw8SgQHzKtCKZscCMR255ZremWhcN8QhKhgtI6YXVDKXySjouMdgYSeO
         0rZQ==
X-Gm-Message-State: AOAM533Yy41BuHTy68aLwP7Y9XBFBDbYA67QZBpQMglFWBENA54vdE/7
        RXwMqViWJ/0AtVm34mg6q9U=
X-Google-Smtp-Source: ABdhPJxLkEwEJjXnzGGYSB6LXir0jg6DXN6XAM4KexezS5fgaMdcJOfXPJgYJxBtM0cpxxrSAT/DpQ==
X-Received: by 2002:aa7:dc0d:: with SMTP id b13mr23506987edu.170.1614010788893;
        Mon, 22 Feb 2021 08:19:48 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:19:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/5] MAINTAINERS: mark sections from Ralf Baechle orphan
Date:   Mon, 22 Feb 2021 17:19:01 +0100
Message-Id: <20210222161905.1153-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The domain lookup for linux-mips.org fails for quite some time now. Hence,
webpages, the patchwork instance and Ralf Baechle's email there is not
reachable anymore.

Ralf Baechle has not been active since February 2018; so, set all
MAINTAINERS sections with Ralf as sole maintainer to Orphan, and give
others a chance to claim maintainership if these sections are still of
interest.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7924907cd7cc..e949e561867d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2997,9 +2997,8 @@ F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
 F:	drivers/iio/adc/hx711.c
 
 AX.25 NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.linux-ax25.org/
 F:	include/net/ax25.h
 F:	include/uapi/linux/ax25.h
@@ -6341,10 +6340,9 @@ S:	Maintained
 F:	drivers/edac/highbank*
 
 EDAC-CAVIUM OCTEON
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-edac@vger.kernel.org
 L:	linux-mips@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/edac/octeon_edac*
 
 EDAC-CAVIUM THUNDERX
@@ -9307,9 +9305,8 @@ F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
 
 IOMAP FILESYSTEM LIBRARY
@@ -12378,9 +12375,8 @@ F:	net/bridge/br_netfilter*.c
 F:	net/netfilter/
 
 NETROM NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.linux-ax25.org/
 F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
@@ -15473,9 +15469,8 @@ F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
 
 ROSE NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.linux-ax25.org/
 F:	include/net/rose.h
 F:	include/uapi/linux/rose.h
-- 
2.17.1

