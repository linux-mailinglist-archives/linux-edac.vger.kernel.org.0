Return-Path: <linux-edac+bounces-1926-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3B098683B
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 23:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F2E1C214F9
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B014A4F0;
	Wed, 25 Sep 2024 21:20:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1C2AE6C;
	Wed, 25 Sep 2024 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299202; cv=none; b=q707CHtk1nvpaCszl5PGLr2pNURbhKVPrF4RLf0ltY7ZGr3TEvpPRWfG3BKbjhbaBfP+ZMfT6rUd8K6/OrlFmjCC+//DvQ+E/PRG4AzUVS9GRer2V52irmoYSHHgqtjqHrrJMYxHxeJAlSJ7ijy+l3BoA3yePm1r6hLAl2XPlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299202; c=relaxed/simple;
	bh=stYZviXEVeTqO5NCg3QLn5Ip1fBQFWbSQIgfr5LN2I8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eKrazT3iTmZpVbZVeodXhfeX/X/VIJKnRgKG3h9LjXKpe4Vu2GEY5lkJhxMwWeb/p+Abwc5jvbTJfLjxQp0ZW6oVZ2x6sd8N1VsJncVoELwOhI4mmhRyVGJpdmvG8y8v7AITNhDmjdNaHkU/i2p3tbRakXUZPWMabetNuF2bpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3381892009C; Wed, 25 Sep 2024 23:19:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2742992009B;
	Wed, 25 Sep 2024 22:19:51 +0100 (BST)
Date: Wed, 25 Sep 2024 22:19:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux-mips@vger.kernel.org, linux-hams@vger.kernel.org, 
    linux-edac@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Ralf Baechle
In-Reply-To: <20240925-flashy-innocent-goat-afdbe8@lemur>
Message-ID: <alpine.DEB.2.21.2409251733580.3358@angie.orcam.me.uk>
References: <20240925-flashy-innocent-goat-afdbe8@lemur>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Sep 2024, Konstantin Ryabitsev wrote:

> Ralf Baechle is listed as the sole maintainer for several MIPS- and HAMS-
> related subsystems:
> 
>   - EDAC-CAVIUM OCTEON

 Cc-ing <linux-edac@vger.kernel.org> for this subsystem to widen the 
audience.

>   - IOC3 ETHERNET DRIVER

 Thomas, is this something you want to take?  I have no such hardware.

>   - NETROM NETWORK LAYER
>   - ROSE NETWORK LAYER
> 
> This subsystem lists a comaintainer:
> 
>   - TURBOCHANNEL SUBSYSTEM

 I'll handle this subsystem and I'll submit a change to mark the other 
subsystems as "Orphan" unless I hear otherwise by the beginning of next 
week.

 I note that Ralf is already listed in CREDITS, so there's nothing else to 
do here.

> I believe linux-mips.org went offline a few years ago and never recovered, and
> by this point any mail sent to linux-mips.org is bouncing.

 The site was restored back in 2021 and worked until early March this year 
when DNS records expired that were owned by Ralf himself.  The machine is 
still running and under control, though will eventually be decommissioned 
as useless in this current situation, with some contents such as the git 
repos and the wiki hopefully preserved elsewhere.

> Please submit a patch to MAINTAINERS removing linux-mips.org references and
> either:
> 
> - finding new maintainers for the affected subsystems
> - marking these subsystems as "Orphan"
> 
> The goal is to not have any bouncing addresses in the MAINTAINERS file, so
> please submit a fix as soon as the correct course of action is decided.

 Absolutely.  I'll handle all the non-e-mail linux-mips.org references as 
well as required with the upcoming change, possibly a small patch series.

 Thank you for doing this clean-up, much appreciated!

  Maciej

