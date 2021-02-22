Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F870321CAE
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhBVQUv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhBVQUk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:20:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C8C061786;
        Mon, 22 Feb 2021 08:19:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l12so22783647edt.3;
        Mon, 22 Feb 2021 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T9Pi1/r4MEa5QWRWvsI+CTI8gMfSCUto8OFZEhxrY/g=;
        b=CnnrMRe5GEPk3C579NMVrKv6wO+D/Qt+cOPZXOa24KjjapocTsGMKpuRs/cu/Ntl7C
         eHVg7p8SmvTQhfqJGc4aI9Q2zvce3hW5TzGdvw05gMo7aOin8e1Yhowg8J1qU+avfula
         AGQyFsf1U7cG/UUiTh5h0fY/I/mnrZ6WVNLTzGjDZVpdXmYrWN2x5xoXwV0HoTHzkwUn
         wfwDAxlfrWmdeyv3OLK7qadbB0cqSXFNUl9nDO5ZVZK562V4ynlpcX462dpYfs8BVOf1
         0/kvJrPkpLt9vTC8N2WeJvqB0sJQNRHttfYtMkInXZsGS7ZnMpBNFEmwDddQvxlidtzD
         B0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T9Pi1/r4MEa5QWRWvsI+CTI8gMfSCUto8OFZEhxrY/g=;
        b=CnC9JysFt63J2/igAn1WEsJTOv6370CF+t2tmLR2TfVJ2+aLdlf8GMRZj0MhOUQzse
         N7mKg5MqOctiKmqvU1CBzlhKt3AXwta6OxliZQ5br7jhQlOqyxUWgOME8NKP38XWa69j
         DmM5QLtT8OPIPar+t5AIbEZGKNIVjzUroRpOBZR8hM++U1sg5e/oOAR8rmiqvGqou3vG
         RnGPWZuhjmBBLrSZ8K6lUhrzA0UsaKocgLxLZSeOin27rCK8ptN4S/OwfiPVsWJEhnAK
         h8h+QIAhBDCpQl0buB1E21Zm5H7HJhqZ+/OQ2ZEm761Hza2wmoen1jtrTc1fcii33jVN
         00IQ==
X-Gm-Message-State: AOAM533DIgp4E33Ahviw/r8F6s5FfgM/wwaRGk1xHNtWpORs7qvoc7CB
        FQGo08BIHNhhxQfTywD3+tnAxYKAxL62mg==
X-Google-Smtp-Source: ABdhPJwn7XdqIFjkUkzt8xrA8apv+V9TrkvjbZld8dManZVAOJ+Z2dF0t4W7D8zP7YD+Z1KnDCV7wA==
X-Received: by 2002:a05:6402:6c8:: with SMTP id n8mr14445186edy.27.1614010796335;
        Mon, 22 Feb 2021 08:19:56 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:19:55 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/5] MAINTAINERS: remove linux-mips.org references
Date:   Mon, 22 Feb 2021 17:19:02 +0100
Message-Id: <20210222161905.1153-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The domain lookup for linux-mips.org fails for quite some time now. Hence,
webpages, the patchwork instance and Ralf Baechle's email there is not
reachable anymore.

Remove all references of webpages from linux-mips.org in MAINTAINERS, and
refer to the kernel.org's linux-mips patchwork instance instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e949e561867d..703a50183301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4980,7 +4980,6 @@ DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/wiki/DECstation
 F:	arch/mips/dec/
 F:	arch/mips/include/asm/dec/
 F:	arch/mips/include/asm/mach-dec/
@@ -11932,7 +11931,6 @@ MIPS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/
 Q:	https://patchwork.kernel.org/project/linux-mips/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 F:	Documentation/devicetree/bindings/mips/
@@ -18248,10 +18246,9 @@ F:	arch/um/os-Linux/drivers/
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
+Q:	https://patchwork.kernel.org/project/linux-mips/list/
 F:	drivers/tc/
 F:	include/linux/tc.h
 
-- 
2.17.1

