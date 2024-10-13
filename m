Return-Path: <linux-edac+bounces-2025-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7F99BB4A
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAE11C20F2E
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2314A4DD;
	Sun, 13 Oct 2024 19:34:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21546126BF2;
	Sun, 13 Oct 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848092; cv=none; b=aWKlMLiLew7E7oq67R/HSNfCFFek2eUmDBya0MsrxECUPM8+N+CDEH1d0TEcORJUVDc4snBr/8lk3/OBiJ+4f8h71d7Ephai4gvmnePyTk4sfqi6eHRR8dcQCCGhQeFKboHLp82laydWW2GTr1pGhaYP2DIbVO1ASz+oFqQzmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848092; c=relaxed/simple;
	bh=+W600ViD6J2T4uI4xy/eANyrToiefAS6zZExmfANrjU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jPJuFc6pMZQv5W1Qy2z+f6TFA7P4f2/UFY8IocCTYzdRAw6W3hVOvaF8AdwsBESgTF7ayi52X/SPW0fITbynktq5PL/C45FWffbLEMWNjrDcF8SZuIqMjRO2bXQqm3X/06FyCv99Cl8RCtWLuMGxnf+fCmgzWG6d1Mq9kqs/wO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 178899200B3; Sun, 13 Oct 2024 21:34:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 10AE492009E;
	Sun, 13 Oct 2024 20:34:50 +0100 (BST)
Date: Sun, 13 Oct 2024 20:34:49 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Remove linux-mips.org references
In-Reply-To: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2410132011470.40463@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
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
@@ -6320,7 +6320,6 @@ DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/wiki/DECstation
 F:	arch/mips/dec/
 F:	arch/mips/include/asm/dec/
 F:	arch/mips/include/asm/mach-dec/
@@ -15518,7 +15517,6 @@ MIPS
 M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-W:	http://www.linux-mips.org/
 Q:	https://patchwork.kernel.org/project/linux-mips/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 F:	Documentation/devicetree/bindings/mips/
@@ -23636,7 +23634,7 @@ TURBOCHANNEL SUBSYSTEM
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
+Q:	https://patchwork.kernel.org/project/linux-mips/list/
 F:	drivers/tc/
 F:	include/linux/tc.h
 

