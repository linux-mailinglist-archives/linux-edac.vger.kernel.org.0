Return-Path: <linux-edac+bounces-4159-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8800ADDB3B
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 20:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC9D403386
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AED2EBBBD;
	Tue, 17 Jun 2025 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OyDVHcSI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D920B807;
	Tue, 17 Jun 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184486; cv=none; b=j1xx85dSSO6nso1xN9vOIQOJNQCseIKBH5cPO98tHYBU9mPx7b2FLCvNQfFMhXmIi4p/RB0NvVgZGsbhIbWgV19JVWodGcIh/tQoFmDE9mxT30RANXFVS2U0XDCUCY/JCtGP8Q7OTBE0jfa7l662dWRrGAeJc8R8ZgFNtdGx46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184486; c=relaxed/simple;
	bh=ca1pqeUUYdNBjb5aKgd9X3bLMs6eD02lm8t8Z94ghGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9Kyfuoq8smJi1YXEl6TJPmGauzODv1MOVv1OPpll2aty6nuOkW+MKjLyGiQImgNkHRSH7CnQsz5jrJeIFChs0Lx4S4Jh20Qxwqyhlw+/k6+bZXw02EmzE2BTPYC9XN/iSEcad4VFIMDIylOz2j9z/J9A6HN7JxRtGeIidXV8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OyDVHcSI reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD26A40E00CE;
	Tue, 17 Jun 2025 18:21:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jkF7SojKg970; Tue, 17 Jun 2025 18:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750184466; bh=Jr1SmqEVGr78eRS+9Bu42wkB7HnuJm2dwGy18HYJtuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyDVHcSIYD6Rff+0JXcaUURHMOeev8BaWw3y1VL4da5N+83/C/tFlHQQM8coubg91
	 dB56G12zroDgNqJflW72F2SWZnDlHYY6AJs6menfQaHYpY92wIAFVwrEuZZI+Yhozb
	 yEeUAh479REFziBgt6emBLflk4CwLVuj1Rrs/WgJBnA3KfPpvSnRRDMhhkOqSpCJDD
	 XQjuFWkL2+4sQms6xWwN1LdUb7l9bWlVLanFObBMnrHBeJeC5T6c8Ik1BHtCID1s6n
	 yEt6CL+vcv+Ht7i4mYBMcSKnzk3bnrfOsJ2y1x3XBqgvdc3L35O7F0Zu6vTT0UCSZM
	 fAvBzTO/qii+qCnm5AT3d2EMK1QJ1wrJjLr+8MjpMBXLh//DA+rewptPNf69QPDJX6
	 90EtUyYa84JsdbvQRTw9e7UfQC9qOW4jVe5lYmgVcgRMrcYFjCBacrHVPbyi87RRw7
	 x0/wui9A27hQvCtpmToCdtS1v59d8UDZ+ojhf3M1iET+vYm/WmZiOw053SZwQIFj/Z
	 ev9aF2plHyLL/wW09I44OSWPvbsHamq4YQfXOCdUR5D9giVK8LQ9e8R5i1owMsRPAO
	 almCVpn6umulzenNuo8HnIOawNvHLqGQZS/N/SsiAXTWh64Etd3ieIY3fX2dJVHMuR
	 cAOCOjQIrJBBQCMoktJuX1Rk=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C74B340E0169;
	Tue, 17 Jun 2025 18:21:01 +0000 (UTC)
Date: Tue, 17 Jun 2025 20:20:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	"open list:EDAC-IGEN6" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: NULL pointer dereference in igen6_probe - 6.16-rc2
Message-ID: <20250617182055.GHaFGyByH_B0r3fTql@fat_crate.local>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250617115707.GBaFFYE61vYHNuAkxR@fat_crate.local>
 <CY8PR11MB71345FDE3DF74BAF97B563F08973A@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250617145150.GCaFGBBvUvkrtpO9j_@fat_crate.local>
 <CY8PR11MB7134444B84D6860AFF1C85078973A@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134444B84D6860AFF1C85078973A@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 04:16:41PM +0000, Zhuo, Qiuxu wrote:
> The maximum number of detected memory controllers is bounded
> by the macro NUM_IMC [1]. This value is what we know as=C2=A0the maximu=
m=20
> possible value now.

I don't think you're answering my question:

Can this happen in real life and why was it added?

        if (lmc < res_cfg->num_imc)=20
                igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d =
detected.",
                             res_cfg->num_imc, lmc);

/me does git archeology...

Aha, I guess it can even with Intel and official fw and so on - not only
coreboot:

20e190b1c1fd ("EDAC/igen6: Skip absent memory controllers")

> I'll make a patch for Marek to test first.=20

Yes, that would be the right thing to do.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

