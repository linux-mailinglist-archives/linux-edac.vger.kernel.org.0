Return-Path: <linux-edac+bounces-2024-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B00A99BB46
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDCC1F2174F
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877BB14AD29;
	Sun, 13 Oct 2024 19:34:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA9126BF2;
	Sun, 13 Oct 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848087; cv=none; b=KctyEAquQfWnnOh8D1Enfb4A5TNOl4fBVNdiFkoARFcr4q+8aPcHM6NdM+t1Xh3Rgv8GQqe7M4WFeW30XBiin53z2cPIcBZ/Fnnne16xFWdnuQQmsPZGKsS0vQ1CcSqinfm7yKsJEy5TJiepUoBBNZJkwNZbAYEUzNWTTSZFp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848087; c=relaxed/simple;
	bh=J45mczNZLx32/rlqL+5tbId6jsdRMMUgUmmRW+uf1Mg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pEj0Q3GiHfbGQFdAtOt2iDFm1i6B/uog04GONChqZRACBtiLScbYW+6hHREs6tLVCBvMbNhZD/Meky8fHGQhpXoUKIh1CqJfmaNQ8M5k8RfT3T58qho4N5HalZPXcaof/D+FLh2hexGRjzMI6QEHud0e8IN3gXkXbjAJvSkhjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3DFFC92009D; Sun, 13 Oct 2024 21:34:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 36DD392009B;
	Sun, 13 Oct 2024 20:34:44 +0100 (BST)
Date: Sun, 13 Oct 2024 20:34:44 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: Retire Ralf Baechle
In-Reply-To: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2410132006220.40463@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Ralf Baechle has been inactive for years now and the linux-mips.org site 
has gone down.  No replacement contact information is available.  Thomas 
has been kind enough to step up as a maintainer for EDAC-CAVIUM OCTEON 
and IOC3 ETHERNET DRIVER.

Update MAINTAINERS, CREDITS, and .get_maintainer.ignore accordingly.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 .get_maintainer.ignore |    1 +
 CREDITS                |    5 +++++
 MAINTAINERS            |   13 +++++--------
 3 files changed, 11 insertions(+), 8 deletions(-)

linux-maintainers-ralf.diff
Index: linux-macro/.get_maintainer.ignore
===================================================================
--- linux-macro.orig/.get_maintainer.ignore
+++ linux-macro/.get_maintainer.ignore
@@ -3,3 +3,4 @@ Alan Cox <root@hraefn.swansea.linux.org.
 Christoph Hellwig <hch@lst.de>
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>
 Marc Gonzalez <marc.w.gonzalez@free.fr>
+Ralf Baechle <ralf@linux-mips.org>
Index: linux-macro/CREDITS
===================================================================
--- linux-macro.orig/CREDITS
+++ linux-macro/CREDITS
@@ -185,6 +185,11 @@ P: 1024/AF7B30C1 CF 97 C2 CC 6D AE A7 FE
 D: Linux/MIPS port
 D: Linux/68k hacker
 D: AX25 maintainer
+D: EDAC-CAVIUM OCTEON maintainer
+D: IOC3 ETHERNET DRIVER maintainer
+D: NETROM NETWORK LAYER maintainer
+D: ROSE NETWORK LAYER maintainer
+D: TURBOCHANNEL SUBSYSTEM maintainer
 S: Hauptstrasse 19
 S: 79837 St. Blasien
 S: Germany
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -8081,10 +8081,10 @@ S:	Maintained
 F:	drivers/edac/highbank*
 
 EDAC-CAVIUM OCTEON
-M:	Ralf Baechle <ralf@linux-mips.org>
+M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-edac@vger.kernel.org
 L:	linux-mips@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	drivers/edac/octeon_edac*
 
 EDAC-CAVIUM THUNDERX
@@ -11902,7 +11902,7 @@ F:	Documentation/devicetree/bindings/iio
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
-M:	Ralf Baechle <ralf@linux-mips.org>
+M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
@@ -16043,9 +16043,8 @@ F:	net/netfilter/
 F:	tools/testing/selftests/net/netfilter/
 
 NETROM NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linux-ax25.in-berlin.de
 F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
@@ -20117,9 +20116,8 @@ F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
 
 ROSE NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linux-ax25.in-berlin.de
 F:	include/net/rose.h
 F:	include/uapi/linux/rose.h
@@ -23636,7 +23634,6 @@ F:	drivers/net/tun.c
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.linux-mips.org/project/linux-mips/list/

