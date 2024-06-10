Return-Path: <linux-edac+bounces-1247-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26EA901B10
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 08:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD01F22276
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jun 2024 06:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988A14267;
	Mon, 10 Jun 2024 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jo1w4pwy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573131401F;
	Mon, 10 Jun 2024 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000386; cv=none; b=QH6d1mbn0KVkVxo7P/FAJYp0uy81PotFqlY3qWkoLrBxloDNsYRu09RO3/M8pxRaalb88ri7m/KiW0KxjoEhNJdci9qM3ldGxDcH1F9xkMM2Gc98jFxcbMXlCQCaO43/ywN/mOeMCAEUgjHgkeN66iTxXnOgq1fKf7yt39UnrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000386; c=relaxed/simple;
	bh=zQb3oERN7ErG1aiDiqNHercf7kxHyzcW7Hw9krMFebA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj/RoBOEj0/KstbHdvT24oZyNx40LM89uMUGpxJ1TT203/oUiwI0CAyjob1CCfFjuW57uaaWLwSCsJQLtnVZsEeY17bBfCyqk9l3ZgP4rvt0aL0EWwmEyPwci0r6MSMEUId8Z/pfIZqlkSlUqT+iYpyiN7QUvwdrERf/RCrpQPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jo1w4pwy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F57040E0176;
	Mon, 10 Jun 2024 06:19:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tdbC-j0RJhCj; Mon, 10 Jun 2024 06:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718000380; bh=KBBN8Z2rOxKnB/fB///OmuRR8YvuDnDRBqlpDa5oKsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo1w4pwyIpjDbrt6BbMKx8DdStSB8EE6FT0NuOpvQ9iz09/SCJiXL+uqBJQ9eayCt
	 Ag+tW9gAecubMPKjD38eRlWpqaHQ2nuPrRloj0qSkwhBq/DymovOVFDMqpFrOMlgK/
	 63iQyWCgg/IMsWFR8skCV0GB8jmqTJrPNkq4SGtVbI3beTMP4vqshFLogNtaoNMasx
	 GPBasLLfpccX/YEQ6A0+6XtC+nu1ct7ISTAznQn7cPuLKEdunHQsJPZgIWfB6EX4mE
	 CZuKJjmyVdQzeNR+vztMg5Ksn5f6VW7ReQ0G0MnaVdNwtSx1iiR06PBtCG5UTZsIM2
	 LZHSzGE+dZLegWV4ODo31HJqrQ2gA2Xx2qYnkijY8AJWhthTivmB6HKAokbo3glfgO
	 D++S5+U9XOvqeK4PS+UsWHVQH+qo5IE6q+fUSDZ88zxgoXffpRo3xtpynxBFGbiNoy
	 oWCx7sB1cnzfCREk/GxGkn1Tho1j9xMeOrak5AbaGtI0s0W5xQyIA1THkhfgpb+y2V
	 d7Xfou8y5cD9ddO2M17ds+s40/Ve1g7DliIYSkfFeKlQvFj4bTPL+r9CyDKTE5TxSe
	 /j5FhFEMc4xshHA2ZEGca0WW1ktOT6oikgbjdmHRSpxOCBN2KIhviJqMFZDgK8oqKu
	 SUl2TVmJkB9NDgAnTr02HAfA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E98C640E0081;
	Mon, 10 Jun 2024 06:19:34 +0000 (UTC)
Date: Mon, 10 Jun 2024 08:19:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MI300 DRAM address translation fixes
Message-ID: <20240610061934.GCZmaa9s4AQZU98lza@fat_crate.local>
References: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>

On Fri, Jun 07, 2024 at 04:32:58PM -0500, Yazen Ghannam wrote:
> Hi all,
> 
> This set includes fixes for DRAM address translation on MI300 systems.
> These are needed to produce the correct system physical address for a
> memory error. The system physical address is need for reporting and
> page offlining.
> 
> Thanks,
> Yazen
> 
> To: Yazen Ghannam <Yazen.Ghannam@amd.com>
> To: Tony Luck <tony.luck@intel.com>
> To: Borislav Petkov <bp@alien8.de>
> To: Muralidhara M K <muralidhara.mk@amd.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Yazen Ghannam (2):
>       RAS/AMD/ATL: Fix MI300 bank hash
>       RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation
> 
>  drivers/ras/amd/atl/internal.h |   2 +-
>  drivers/ras/amd/atl/system.c   |   2 +-
>  drivers/ras/amd/atl/umc.c      | 160 +++++++++++++++++++++++++++++------------
>  3 files changed, 116 insertions(+), 48 deletions(-)

Both queued in edac-urgent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

