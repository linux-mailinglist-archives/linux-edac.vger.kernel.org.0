Return-Path: <linux-edac+bounces-2023-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64B99BB42
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 21:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721302817CA
	for <lists+linux-edac@lfdr.de>; Sun, 13 Oct 2024 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4111414A095;
	Sun, 13 Oct 2024 19:34:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33206126BF2;
	Sun, 13 Oct 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848083; cv=none; b=IuEty3BEeXsVJYjlL/0yjKfyeTCA49etZe2X+Gq3J1j9VjSjQbT1PGVuohkRbLw98wiWyFkj3BKDgiZiPFI9/qoL+A8Io/ocCJj+Oe2y1USoG6Bm06vQkaKN57/zICUv+7bfmQCE61ypLfVmpjlE9oMubmeB7olE5byxd7WM3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848083; c=relaxed/simple;
	bh=liFsmPYzIGrqewj5ejvubldRxcOutBFiINTtsDEWIoM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=SbQp8G81dB/nnPegKN9L7pb+B+1GidrHNekAY369U27dG8nOoOoAdmn9b2cuXSuTUbSm/BDed+xrI+m3LNVxm8HJ9tYEN1yIOXLyuGvcp4rjxtan/7nlnGByXVxSQ6O1Vwn9yM/bD0OTRIWN6Bc+Yuq3Ug6O8Q8KfM3RPUXGduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 89ED492009C; Sun, 13 Oct 2024 21:34:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 840B992009B;
	Sun, 13 Oct 2024 20:34:38 +0100 (BST)
Date: Sun, 13 Oct 2024 20:34:38 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-edac@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MAINTAINERS: Deal with the linux-mips.org mess
Message-ID: <alpine.DEB.2.21.2410131952550.40463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

 As promised and with extended wait time here's a small patch series to 
address Ralf Baechle to have stopped responding and linux-mips.org gone 
down, and Thomas stepping up as a replacement maintainer.  Please apply.

  Maciej

