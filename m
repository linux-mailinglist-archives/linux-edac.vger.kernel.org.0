Return-Path: <linux-edac+bounces-4809-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89031B586E0
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A632068EE
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE052C027D;
	Mon, 15 Sep 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="S5xncN0h"
X-Original-To: linux-edac@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78A2DC78E;
	Mon, 15 Sep 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972638; cv=none; b=J5TI45kneG7rFTwNS6rgChIRYVLTEECtOpKHyfPvH1nfgAaBenIBHK3yLgmkCliSEDtWXQ/aoeamUcFaVsxZrscFtzB48ak3Iiy6eD2jMfw4FxdEo7oy+Z+SObKd9F+HomxJSPOBwt5bho8r9MQsPEXPAjDH7/EAoXFKgdroFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972638; c=relaxed/simple;
	bh=xjgZHmSX6hQbMFsYHzBYKTo0y92y46Oz7JhFxVO451M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4D2uheJ00BUQTgQtC53Jy36NHzMxLuK1XwwwZTyxR8+ishyn7HED+SOvM25qiMA1bf1UjbksE07LjNmbvV14FQRjmDgBvugvivz+ceRlLfwbWHd2vxbJIES2fLlAs7NTfPAPn0CGC+F42gL8Ifco2MAA8m0cyTpq5wLxTzPW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=S5xncN0h; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757972608; x=1758577408; i=spasswolf@web.de;
	bh=ChbW6nEJU0PthS6uGA2+zqeh5CtfztIx0o/3V2HypMk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S5xncN0hbPU+ZvkxJlWxns9h5/tqAMImSexuWvzKyLQdGAxavhUOkNqrQsg0ieSD
	 i8LgbRS/Byab32f/tnqrWvC5WKmuKAhtZ7z1BcLO6Q6+vZ08w8DB1850PtFtQrOGk
	 s++K3RcVKeK/fP/m+3N6MSrFZmRVjjufpt8aVqafZISCGdKXWUG2BjV6s8WLnRDmO
	 nt9I/OGIkQQ/UsxA33tsNv8hB1p39LorkJCYVxHFgq3mmJtKgWgXIW7QCgK0FWO8J
	 HaXAYPXkTMYWJ6DeYKdD0ABZTETof47y9bNYq88L8izZ2AQiJJNNx0FFAmDnDX4w2
	 cy7KCYcjKYuDQBIeQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1vC4lm2W7G-004RtJ; Mon, 15
 Sep 2025 23:43:28 +0200
Message-ID: <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
Subject: Re: spurious mce Hardware Error messages in next-20250912
From: Bert Karwatzki <spasswolf@web.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, 
	rafael@kernel.org, qiuxu.zhuo@intel.com, nik.borisov@suse.com, 
	Smita.KoralahalliChannabasappa@amd.com, spasswolf@web.de
Date: Mon, 15 Sep 2025 23:43:26 +0200
In-Reply-To: <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
References: <20250915010010.3547-1-spasswolf@web.de>
				 <20250915175531.GB869676@yaz-khff2.amd.com>
	 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPp+c/vanHcGtDgNLx/d+0zjej9inOOzO58zyA4Ff75Bx2fKQAy
 ekG78KDdaxRKwzUVniZ4In1Bp0Iy/f/G45fDbSAToTUoJdXj3EegSjzn2kHJah8qdV8lzoa
 grgutmQc+HgT4jfGV3Uz1/3fO3lunAH2jviik6HK3idsyCIP3E5fyjYmeXWW1xowb61zMaE
 50Y9A6rt9soovPFGrUcGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TnkBAmGK0qU=;7LYxyx78lwrwfuQBQs9UwWmeiI0
 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

Am Montag, dem 15.09.2025 um 23:03 +0200 schrieb Bert Karwatzki:
> Am Montag, dem 15.09.2025 um 13:55 -0400 schrieb Yazen Ghannam:
>=20
> > >=20
> > > As these messages do not appear in v6.17-rc5 I bisected the issue=20
> > > (from v6.17-rc5 to next-20250912) and found this as the first bad co=
mmit:
> > >=20
> > > cf6f155e848b ("x86/mce: Unify AMD DFR handler with MCA Polling")
> >=20
> > Could you try another recent linux-next build without the MCA updates?
> >=20
> >=20
> >=20
> > It looks like 'next-20250911' doesn't include the commit above.
> > >=20
>=20
> Somehow I cannot find next-20250911 in my linux-next git:
>=20
> $ git checkout next-202509(TAB TAB)
> next-20250901   next-20250902   next-20250905   next-20250908   next-202=
50912  =20
>=20
> I'm currently re-cloning linux-next.
>=20

After re-cloning linux-next I tested next-20250911 and I get no mce error =
messages
even if I set the check_interval to 10.


Bert Karwatzki
> >=20

