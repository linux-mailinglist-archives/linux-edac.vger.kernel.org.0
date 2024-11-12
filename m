Return-Path: <linux-edac+bounces-2509-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE79C5B8B
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9273DB62560
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB1F1FCC41;
	Tue, 12 Nov 2024 13:47:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB481FBF64;
	Tue, 12 Nov 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419249; cv=none; b=W9ux8P/GVSTqoiQEpFsu4J7EPnlS62VjHKE7r+FD4puposfWntxiH+VV/fwE9oPEncKHV0e3RcQGdc2DvIKCiAqW87vxCPL7wndVJaHo8KCirkrMoBrncZ8KjcmzUFxIlIWH7U32BYZJ//cXdMO9pc4WLZptDWCVtBYCuhJAoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419249; c=relaxed/simple;
	bh=5ArK71moMUz+0XzvtNm9YLk8hPSBH1lwzi7IBWPvmiA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WmtI5Sef3+UX93I3Gcn7niad7nkCZD6xQ4RSxDbSzGT9ktfmBvOtw8lsJofOMI+i3xXgBXpK3YlbHAxUB9yAUYt625LPsyEV9QoAGC/5dKn++k44O0yJk+CPwICDaydn+PAhHeCAvAXLVh8tL3Kfr7bvoKItpZrPJRBaNNLVw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 189639200B3; Tue, 12 Nov 2024 14:47:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 152E392009E;
	Tue, 12 Nov 2024 13:47:26 +0000 (GMT)
Date: Tue, 12 Nov 2024 13:47:25 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] MAINTAINERS: Remove linux-mips.org references
In-Reply-To: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2411121344350.9262@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The linux-mips.org site has gone down and no replacement is available at 
the moment.  Remove/update references in MAINTAINERS accordingly.  There 
are a bunch of Kconfig references still present; keep them around for a 
possible future update or for people to refer to via archive.org.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 MAINTAINERS |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

linux-maintainers-lmo.diff
Index: linux-macro/MAINTAINERS
===================================================================
--- linux-macro.orig/MAINTAINERS
+++ linux-macro/MAINTAINERS
@@ -6301,7 +6301,6 @@ DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/wiki/DECstation
 F:	arch/mips/dec/
 F:	arch/mips/include/asm/dec/
 F:	arch/mips/include/asm/mach-dec/
@@ -15480,7 +15479,6 @@ MIPS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/
 Q:	https://patchwork.kernel.org/project/linux-mips/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 F:	Documentation/devicetree/bindings/mips/
@@ -23555,7 +23553,7 @@ TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
+Q:	https://patchwork.kernel.org/project/linux-mips/list/
 F:	drivers/tc/
 F:	include/linux/tc.h
 

