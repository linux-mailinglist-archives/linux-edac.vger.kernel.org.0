Return-Path: <linux-edac+bounces-2508-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA19C5979
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DA0282E2E
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 13:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42C1FC7CC;
	Tue, 12 Nov 2024 13:47:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0756F1FBCAE;
	Tue, 12 Nov 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419245; cv=none; b=duyi+fLzOVAgKs/CSEE41MfvDMERYe7e/wxC8jJmdDpCyQM18JIMSQ+C5GcR1v3AeqpD5DMUuygC/orD0ai4rbdjkSmRBMkJMdI4Wg26qoRQ04o+9ZRGeBr9LSNcL5q8Mv0Aj08/OSnUGNpeYGdZOpqnjWlyWEOSZaq3ZPbsIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419245; c=relaxed/simple;
	bh=SQvu39UMkmxXUqZ1zdfBt7bxc1VV6/TpvuUCJgUbD5g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WtdZydJ7rHfNowYumH7eYrwn/i4c9cgMgZCDm+T460b7PMakYusZKB96J02Pqq30Ol8XFdpELUb95SNPaDhIEOWJEau2gQuzmsWj5E1rQKT2zJXKkxhoiNQXTLPlJfU5pFWNHFawNKP87spZbSJxboim0AU7PHSkM0AS/VQuPHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AD42D92009D; Tue, 12 Nov 2024 14:47:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A94F092009B;
	Tue, 12 Nov 2024 13:47:21 +0000 (GMT)
Date: Tue, 12 Nov 2024 13:47:21 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: Retire Ralf Baechle
In-Reply-To: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2411121342220.9262@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
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
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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
@@ -8061,10 +8061,10 @@ S:	Maintained
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
@@ -11885,7 +11885,7 @@ F:	Documentation/devicetree/bindings/iio
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
-M:	Ralf Baechle <ralf@linux-mips.org>
+M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
@@ -15993,9 +15993,8 @@ F:	net/netfilter/
 F:	tools/testing/selftests/net/netfilter/
 
 NETROM NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linux-ax25.in-berlin.de
 F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
@@ -20035,9 +20034,8 @@ F:	include/linux/mfd/rohm-generic.h
 F:	include/linux/mfd/rohm-shared.h
 
 ROSE NETWORK LAYER
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linux-ax25.in-berlin.de
 F:	include/net/rose.h
 F:	include/uapi/linux/rose.h
@@ -23555,7 +23553,6 @@ F:	drivers/net/tun.c
 
 TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
-M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.linux-mips.org/project/linux-mips/list/

