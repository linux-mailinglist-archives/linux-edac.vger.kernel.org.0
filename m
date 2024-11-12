Return-Path: <linux-edac+bounces-2507-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200149C5977
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 14:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72B11F23522
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 13:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196131FBCB8;
	Tue, 12 Nov 2024 13:47:22 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B41FBC8A;
	Tue, 12 Nov 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419242; cv=none; b=OwOivDoyxugFWdj5KdVTPcfJatY+DmWwulAaU/WMLa46W4xY0uzG+4HIByLq0QvGQyRqxH/OvIBh/7zQ+GLMXAZzAMpfe+rLJ2cCTHGTcUbyoJxLRvrbSQ+LmL8DRoyzbnv9hJLRCng6OkNV44QPiipjb74lZDN+ZxdgzAaaBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419242; c=relaxed/simple;
	bh=RM6EiTlaBDTtPo3gvh2cz9A9HVA/fegHs1dd+O9RemU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ATa7uB5qBN0HZvARS3evfEKA21az0670RkvGVgOKOUw652GVMcbrdM45i5iOEHOcF9hKoJcSaPnC0r1dJDECc1SX+KV9V0nYvIk9+a0HdCmJeEDnnjQcAg+7B5wB8tQT3LoeNIHct5LNMAbV7L60hhCZcWkeq731SO7HfTheXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 1E69C92009C; Tue, 12 Nov 2024 14:47:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1B01792009B;
	Tue, 12 Nov 2024 13:47:17 +0000 (GMT)
Date: Tue, 12 Nov 2024 13:47:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MAINTAINERS: Deal with the linux-mips.org mess
Message-ID: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 Here's v2 of the patch series to address Ralf Baechle to have stopped 
responding and linux-mips.org gone down, and Thomas stepping up as a 
replacement maintainer.  This has been regenerated against the current 
version of MAINTAINERS.  Please apply.

 Previous iterations:

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk/>.

  Maciej

