Return-Path: <linux-edac+bounces-5258-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF0C1C621
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA919961D12
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AE33F38C;
	Wed, 29 Oct 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UZazVAyw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E12C237F;
	Wed, 29 Oct 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753814; cv=none; b=KxopV5VkZa8RiAmu1A1cQx96+K9OlkZz0fywwROfzG4cJWTWaVAYFCwHithScJ1fhIaXeTmh34/f+M+aSAPjJ2QkLfZuTLl6y3+O5qMaL+Hn5yRyZsM9AWBYvsKCf6nLdfegSVM2wk2YPloBXDkh4BxoWVSn8ICTUhdVGPCXW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753814; c=relaxed/simple;
	bh=FfclYtQFAd0PtMjK3+qpS/yxBf1x+RaiFiNBULZ/U3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqb1iCXu6cxo6cHgEq/nCB0eCoAWKIdd7Ha9CKMsmf8lPCI44yugGKzqFCrIR0jE/QlngDLtKxWZI1AD9USA4JwXwmtejNAjgaIbJRDWid9weOwZWILcKqkb++zImRXPZsOT2frjknQpbtfP4o0CjXNF0laF3popbWRq6gV6LG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UZazVAyw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7E2FF40E0225;
	Wed, 29 Oct 2025 16:03:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b68SWlHqScrq; Wed, 29 Oct 2025 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761753796; bh=NvADcwzZ1+racrdbp/ZQj9cqiUpC7r3/HTARgxhUBZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZazVAywJ8fgK3v+5Ph2A87PExEsGP6o2Tr7wjzOks8MgwYk8e/ed4ihqHj8/1UU6
	 +1NiW4ic16ccHZwUWJHu9e1Szr/ZC/TuhCi9iTexIqgSDeQDjXHVgJBRfREeQIchMu
	 I1GMqHHn4kLs2U8hFA/Vl304GjYjHlyE5Fo8NJcO4hDwwE8UEYeeIBH+4+D/Aa3K35
	 TGWMakik5IMwj3LkOQPWRPpshYDclgA81vK9mhxiVHyifRHiaw8sE25AhkQQT5ZM3c
	 ruY0BWgcSw26h+DOTXr66HH12/5C+XaBn+vxvSRGUmRCHBvXRbvIvF2OXAhNplHEsz
	 G3+0316aJT4Xm3RWnlNXgpVIq+JjXqALqDp2cpJB5wqPCcJUJY1JwRfXxFdNkcc9/8
	 yKAOC9Rz8VZmC+01w2dMedFt3Jw9qdpRMUbswEC0Y3G/RLZTgOy9nXJj3/2mm9/9de
	 rxRks8su3d8eEWW4FEznn0ZQVzDxZLrZ5Nu/ZGKfi6C2Zz1ZZEitsMR44itfiMi7Yq
	 jA3qHOoFuYYn42Ofk8f4r4dplKdro2idX58lofQWDaSaQiJv4JrASTsZtjIAJPbk3q
	 Qkdmbb9KYtjWtJ9O7kpdWo2z5D267cDDqKBlquqI7u0mFQO88OcU7NmyynRYrfG0Fx
	 3GkRMLOduj+mQOI1JbMCqCwI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7AE9640E00DA;
	Wed, 29 Oct 2025 16:03:04 +0000 (UTC)
Date: Wed, 29 Oct 2025 17:02:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251029160258.GCaQI6suTDcmG4UHwy@fat_crate.local>
References: <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
 <20251028154258.GA526743@yaz-khff2.amd.com>
 <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
 <20251028203719.GA655216@yaz-khff2.amd.com>
 <20251028231825.GDaQFPQflC7gyVOwMa@fat_crate.local>
 <20251029150912.GA113329@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029150912.GA113329@yaz-khff2.amd.com>

On Wed, Oct 29, 2025 at 11:09:12AM -0400, Yazen Ghannam wrote:
> Why apply the fix ups to that?

Too many patches flying back'n'forth. :-\

Lemme finish going through them and you can send a new set, pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

