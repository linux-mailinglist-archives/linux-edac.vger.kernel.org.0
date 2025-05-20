Return-Path: <linux-edac+bounces-3963-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B77ABE470
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A011BC3A43
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E92882BA;
	Tue, 20 May 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PsfqVZLH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7126AAB8;
	Tue, 20 May 2025 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771521; cv=none; b=Jp50lGommn5mK0gC9pisfPlJCyTZegjITFZu9GHRs8hR9gCFS/9zi9To1LGLvLMY/LpPlVYYOAVaZY3ZW0NYeRMjq70tlQPzDmQQFYu7ot4+yenJ8LQA2P1ot7BlLts2dOQRbFA4CmBRgfpaH1O9H6YpX485pV5flaJCWgQ9NEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771521; c=relaxed/simple;
	bh=b2elypAAH4G4XjApprsZG1KHZuVS+7ibDnFvH7DyXUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx0FcSMXHAgBgxCsSCXlpfpQlvn1M1bK1NlRyT/KMb2SjCLlHvEft+gTJLe8gXodv6nHUHfpN98EfiqbImWQTP2XOjEdfuv3OBjGZ8KB0PuwawU3iMUDR8lHEMrSp0LBSt38GDmVREPa7o3lGhs3kXi7qDAqgBCu06BGazucxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PsfqVZLH reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFA2940E0163;
	Tue, 20 May 2025 20:05:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sXbX_fSGpcAb; Tue, 20 May 2025 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747771509; bh=UCi/hhs8q9kDbXAZ73f/ZqIwTWKb98JUL3llk2mw/4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsfqVZLHvZZYLcly2wFpn1I3eojD2eUYKbcybupUWcjUhBy7nuW/vkys2+4F4/b8U
	 9LWYBxE96bkI3JQIBm0AHvKeEU6qwMZW5qc2zHVNXBPemASUv1HV99n3vxwWne5GSu
	 YjcKc7iW/GkmpNb+csLJs4JMsxef673uM9PkBCoaYbR3MEtcrBggRNKZqnFcOHnfiI
	 HG8ezyrShpDZUfHNBvKLUm76xvM1DymPGuZHGKGJ/LAOktcz5jL9aLJ1D1WpBZWO0v
	 j4zg91L9mMtrTFLvJdsBBMVrcQ2u5/TfwMoD5NQsxFoBw396qdeejCCqXeDeqEvPaB
	 eKDMDzbZF46VxVn1Z2vKZIK5P/IfjR3IPsE2Gtml8V4HmseU1wwnRPrdZ8U1mp5Dma
	 hfqKZ/1eESG6St2Ip39Tl+FMJogYg+tSb8urtKu4ddPNbFBNkSNC6pY8SiSAR3zAjT
	 z7dmsZdoQxsZvkyek6vLfJFm9jslLC0QPWkOvMpE8FRTj5zO0Y6v3a6CgK8iXqtguS
	 nBAO0K75qU4F+m4HOmlxEHPChLlVyFM9BBcZE8zakuq7+6Pwrpue3Xt7iYQUnOIoZp
	 XyCgwW5/bDTaXVlDB3WgreDNhrAp2Fzx842AOPKWgxarQJLclUPfB0+VuQTlmUpNiM
	 umUd/egToipowPr0kAX9ryb8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A031040E0192;
	Tue, 20 May 2025 20:04:54 +0000 (UTC)
Date: Tue, 20 May 2025 22:04:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
Message-ID: <20250520200448.GRaCzgYFnfIjKAgAg2@fat_crate.local>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
 <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>
 <ea19ad06-142c-4d7e-83ba-00b9b7e3cdaf@linux.microsoft.com>
 <4630a9fc-0980-485f-9b70-01558ab418db@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4630a9fc-0980-485f-9b70-01558ab418db@linux.microsoft.com>
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 12:54:32PM -0700, Vijay Balakrishna wrote:
> On 5/20/2025 9:09 AM, Vijay Balakrishna wrote:
> > On 5/19/2025 1:51 AM, Borislav Petkov wrote:
> > > I'd venture a guess you need to protect here against CPU hotplug...
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 for_each_cpu_and(cpu, cpu_online_mask, &compa=
t_mask) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_call_function_sin=
gle(cpu, read_errors, &merrsr, true);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 report_errors(edac_ct=
l, cpu, &merrsr);
> > > > +=C2=A0=C2=A0=C2=A0 }
> > > > +}
> > > > +
> >=20
> > Hi Boris,
> >=20
> > I appreciate you highlighting the CPU hotplug issue. Upon further rev=
iew
> > of surrounding code, I realized we must ensure that the data passed t=
o
> > read_errors() is per-CPU.
>=20
> Actually, per-CPU data not needed as we are passing true -- wait until
> function has completed on other CPUs.

What happens if @cpu above gets offlined right before you do
smp_call_function_single() ?


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

