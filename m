Return-Path: <linux-edac+bounces-5777-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNLzBCH1qmlGZAEAu9opvQ
	(envelope-from <linux-edac+bounces-5777-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:39:13 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE94223F9D
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B4D313EFA9
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F893537FD;
	Fri,  6 Mar 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j4Ej2rZA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4B3612FC
	for <linux-edac@vger.kernel.org>; Fri,  6 Mar 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811164; cv=none; b=A3tjK9GUNwPKPp/IVmce6lHe/uE9gz/+MkjgRFkfGH45Df5RFqzh9xSOSqhr4jT2xA9nVxaCFh9Ow5J9MWoVRiaxgEV+GFope+l2i7j1+JwmwbG2xbbsdR5nsSEXAyYhoBMWCFHVFAARXgrT2d+m1dTSOw5qYnkLgwpvhjMhHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811164; c=relaxed/simple;
	bh=qn2sn1fSsOVfBsG76eTYSJZXlGLwQnjzM63/7V2WyC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG3KRejlunshoetp74U0RplkS872xwsRUn9Sb9h+iq1CBvRLG6nmwhbLYe2ue1NBx3sb5kDNqhLhf0D/3blgvROv9mw5uKq3w6w9mQw5KzYC30j/EJlq5sJP2gHG/FRCzgvsrOnnSOoBf6J/QPSjn74CluZWlvmpwQLsLhJ80u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j4Ej2rZA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E64AB40E00DA;
	Fri,  6 Mar 2026 15:32:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4SCqm0wj7nWX; Fri,  6 Mar 2026 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772811149; bh=fkTEm3sDI0bmWcTAgr+BCFm//sf28XkDgKhIbj08Tbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4Ej2rZAHkCPPDygp+VASK0JA+xVoBKA9X3rfgOAz36WfjXBJv/Kaj4ZBH5ZZkZQA
	 SROphRIefle+CaF8lbfILs7WK4j8Gj39syYOIxeEsiCjxKcI4e66FIlIyQrCdrIOT1
	 +enqcZtCI1Wa7Rb5kvk43QpknegoON30hgGFVLj9xYNXm9mD1KeTcTdv4E299pC7yk
	 0MN2VPCwm30tP6w4n/yfeMHdZpF8vpL1CS5SDfJ+Y3xJSW+H+hWQ0yVC86wFQWo40I
	 DwbZRO+0SKxKtYYeJySEdIlWAvmbus3KvnAqBZ/rTz11FU+f/apRPwO1qFkAi/g6gW
	 AUoy8CLxwmA28PPDaNHQt0RxPFR//S0+74xGEm1vMMICG3D05kNJANQXTOPkIgWcw/
	 ERy7TScRq5GOVI4xv5wzBk7bup5dDYzP0ApOx75kr8wR4pYhvEnCS67jr3RYeyLFe4
	 WIPhq6N+/3LkKzQ8M/SqAyBzwjrOO7K03GpVmpujf/0BDmjd3VzJbHyjjoRNlAEysB
	 T8bdGjHdTSEaVw53xGz2pCTa6FBWs+XhSGS5+EGr2V8+wUiZNh9hxSpE/Y7eEN5L69
	 9Esr7hqGAWq2/HZWBsMTzm+vAnvxS5blw5Wh25BAdaeonxIv98Ijbkl45aFDFiMRNh
	 VB9BP3qf48ELgfml7keH/Z5Y=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8405940E00DE;
	Fri,  6 Mar 2026 15:32:24 +0000 (UTC)
Date: Fri, 6 Mar 2026 16:32:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen.Ghannam@amd.com, Tony Luck <tony.luck@intel.com>,
	superm1@kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
Message-ID: <20260306153223.GFaarzhwApsh3Jdqdy@fat_crate.local>
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
 <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
 <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
X-Rspamd-Queue-Id: 7DE94223F9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5777-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:03:44AM -0600, Mario Limonciello wrote:
> Well in this case the platform /doesn't/ have PRM.  The implication is we're
> not going to have DF support either if the system doesn't have PRM.
> 
> We pass the error codes up so the caller of amd_atl_init() will fail init
> and thus the UMC decoder won't work.
> 
> That's all the intended behavior for such systems.

Yah, I had the hunch you're talking about pure clients... :)

And as such, they should not even try to load ATL because they don't have ECC
memory.

And if so, we probably should check somewhere whether ECC is even enabled on
the system and then stop loading if not...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

