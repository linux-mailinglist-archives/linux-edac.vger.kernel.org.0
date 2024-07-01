Return-Path: <linux-edac+bounces-1447-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89891E842
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 21:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB71283C26
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2716F27F;
	Mon,  1 Jul 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="URIQhaTD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052BC8C7;
	Mon,  1 Jul 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860846; cv=none; b=lh2U08csOKI8dhLrxW6V0jsC/eavEZ0c2ALccxGWJCe1B2E0dro23V36rOD3fBJ/lpT6vGw42PUJcTi0Rfg8YCdAigF+5/xEkwVyUx/ZYyF15VAQJX3Xj76UF0cp+QBVSO4uMEg/w1MFej/KxowD6hRaLB7gC8Ahh1fVRbjBF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860846; c=relaxed/simple;
	bh=BXqpDmhelS53fqFTYgCoicuf3ZcXJwS6pFu7n/nrJNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVU8yLBsJrPAaTWiSGPcnPX9G+Yu8DGE6HSeynFr3i/gPHC/IUpvDKafHwJRfu0TFbpKWyb97bGV4Yna+BIRC4XaHSj7qQ/KCo+up1Vw7CnlixlogkKd7pY7bLOdFJVl2oLwihRpSjjNy9FenfMFYp/T9V5Vxema/QqJVzHoWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=URIQhaTD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B1D4440E021B;
	Mon,  1 Jul 2024 19:07:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 91M11-d0dMNM; Mon,  1 Jul 2024 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719860837; bh=YvgcWqvpapeeWojA6dF/+phZFfl1obRl2CIZRAObln4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URIQhaTDvh0kXZgX12KbyeLXwtEef+DyrJp+u+h0U7jkvt97ah/GP/EvC5JbdFlCy
	 9EB8mN6ns+/mwjGd92gz5pnbki7qp8uLmDmu6mvItKmpSD83X2JEfl7bEXrY8jMf4F
	 9h04etUdKKbqpvdvBid3s5KG7kBC7QtvyEXVqdi0aHGiMrPfJ1QNI7lS+Axd+MY0Df
	 quvc6s+tkNtdsML4ODoiM6sJ12TyGG1fWfeayhQsmXKb75/QWWzWR8zmM/fpuw/nSN
	 UkiCnaZLGvvWeJkdW0ZD6Q1ZX7VB1HGQuie4ia4ZzOgL4gd5PCjTu/J9S7UMxJz9Jp
	 46tBqHCN/PnEN5f1EMAb2P25gKmAu+Q7X6otb/KX1NHlv7HHiS4s2LawrMdIepv/RD
	 oUhYXUo81RMa5hFFYBcTEDjRPvqB+SA5Fain7cj5pVt6g/8S3tNl+R+gt1j8xGUcMb
	 HMPICbAtqJ1G8WAN897PTmLlP13Po3T28An+HlQj+VZMWlLu0kSj7J5vIkt4tJlcke
	 KJtDEeETW+HEZNaSDB1YYCygJfi/nZOB9lhBXuvL9HoelBZtALd4mhkXRkPv77NU3j
	 STEvOFLTqpBoNVFnLRVhnPhkvwSJvfsOutG7EXlgwrOI89SrMngB7M7WSvfiMF6TvZ
	 bnFrH6hZESfGNE5C7senlgv4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 503DF40E0185;
	Mon,  1 Jul 2024 19:07:09 +0000 (UTC)
Date: Mon, 1 Jul 2024 21:07:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240701190704.GKZoL-WBZ19-z8s7UR@fat_crate.local>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
 <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
 <20240628141542.GA124261@yaz-khff2.amd.com>
 <20240628144535.GAZn7Mj4jofP3Vz2xf@fat_crate.local>
 <20240701175142.GA4681@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701175142.GA4681@yaz-khff2.amd.com>

On Mon, Jul 01, 2024 at 01:51:42PM -0400, Yazen Ghannam wrote:
> X86_LOCAL_APIC depends on the logical OR of a bunch of options. So it
> depends on "any one" of the options to be enabled. But it doesn't need
> all of them.

Yes, I can see that.

How does any of that info answer your initial question?

IOW, if you don't have LAPIC support in the kernel, what CPU number should we
return for any APIC ID serving as input, and why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

