Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F93B4224
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 13:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhFYLHC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Jun 2021 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhFYLG6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Jun 2021 07:06:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F749C061760;
        Fri, 25 Jun 2021 04:04:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hq39so14477342ejc.5;
        Fri, 25 Jun 2021 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ng7tRj6/lSIoWL2KQHjFX+1bdImuCLV0Pw9t5mRJilM=;
        b=gz6Q7h1RNgNIY1GSvfSndbMNqWyEBXCBKtyCESqCdHV00xi5882xIjaxnaJTwSRn7z
         IUk+uk2avtU5m2ThyXXkulJAS1ZJCBT+njkiF82jKkvvXMArLL6T8SSY+RnCg5osuJxR
         y+Bmj7Z8tzsDa5ZarRpHwazhGjoyBv4RRncHZaT19pMMp9EZkSmpUjXsExv/KosAqk6r
         5Yo7iU9cO3JIDG3vHyVQ6SNnmPiHqoiJvd5CM7IelKSsPLOhMoqAniMLU/+D7tscP6Uj
         4DnHpBbY5oIaXwvB1DKXq+oXIEN89GVhwiC3wRx3fkQiMxfiuUuISjn8AwJAse+UAwr2
         m0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ng7tRj6/lSIoWL2KQHjFX+1bdImuCLV0Pw9t5mRJilM=;
        b=bln1pKcZuegtY4bv2PP6NmoeuDFjwCx4wcggX2mVFkUYB37dzYD03dpjBzGSfnr4Ai
         Qvm19UzxuY7im7BxsxBl7yrEts4YoqUTQA3Zk67GzFMymHPJG985WZDqTlgNwRfSDbBW
         m77tkn4bzDhZb2sD3SI8yKjHihbneTN33c9cch57dKeaDieky1J1pOUz+7YsihmT3DIJ
         T8oYH/W7316+QEngB2psVw4PKf+X+4JywJ0PR3x7IqkhkW4+nnm4dKHz/OFja+On7Fdx
         DLAkCiZKAE9EY7RN158yHaLJb10LyrV58js5vfGkwHbOBqqillwFNNVOTDgMBTjN3Yhc
         sEWw==
X-Gm-Message-State: AOAM531EsiPNL+ze6Sa5OnSkhkJg2+XQjWzS2GXssa4HJrXEpz5KYVx6
        ohrPACc0jNXkXTG7MTsEUUE=
X-Google-Smtp-Source: ABdhPJwsOeqelIoCOzov4K2OPPkoRMnWJkwwTILELXCpT9dV0FFEUJuEPNu2p72bvyA/mNJcz+DHdA==
X-Received: by 2002:a17:906:c241:: with SMTP id bl1mr10144994ejb.536.1624619073683;
        Fri, 25 Jun 2021 04:04:33 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:3852:f400:9496:6480:6c8a:4419])
        by smtp.gmail.com with ESMTPSA id v28sm2659665ejk.84.2021.06.25.04.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:04:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 1/3] MAINTAINERS: mark sections from Ralf Baechle orphan
Date:   Fri, 25 Jun 2021 13:04:17 +0200
Message-Id: <20210625110419.24503-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
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
index 3d657e1fe359..eb9110c756f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3094,9 +3094,8 @@ F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
 F:	drivers/iio/adc/hx711.c
 
 AX.25 NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.linux-ax25.org/
 F:	include/net/ax25.h
 F:	include/uapi/linux/ax25.h
@@ -6575,10 +6574,9 @@ S:	Maintained
 F:	drivers/edac/highbank*
 
 EDAC-CAVIUM OCTEON
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-edac@vger.kernel.org
 L:	linux-mips@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/edac/octeon_edac*
 
 EDAC-CAVIUM THUNDERX
@@ -9654,9 +9652,8 @@ F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
 
 IOMAP FILESYSTEM LIBRARY
@@ -12832,9 +12829,8 @@ F:	net/bridge/br_netfilter*.c
 F:	net/netfilter/
 
 NETROM NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.linux-ax25.org/
 F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
@@ -16007,9 +16003,8 @@ F:	include/linux/mfd/rohm-generic.h
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

