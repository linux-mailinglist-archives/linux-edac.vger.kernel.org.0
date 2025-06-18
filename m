Return-Path: <linux-edac+bounces-4168-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883FFADEDBC
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3458F16D7DB
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425C2E3AFF;
	Wed, 18 Jun 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="gHL5GTfN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8besaRg"
X-Original-To: linux-edac@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551301EDA26;
	Wed, 18 Jun 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252989; cv=none; b=H8IyMzA7n4dugm/E4FOdtcvHgv5ncdwdbRAiWjF7A2KrACQcM1ZBDh0B3WkB7TCrtGjnZ61QY3C1lCrI/Eb3ntCDOQpOM4L+xob4fWoW994lkN8+ri6AR3ssZkMFxsENHAPmX83XNUK7iCUqts9CpgfBMMla+0G3f3w1El6Mqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252989; c=relaxed/simple;
	bh=5xtEzAj9y8QbOTiFWszUWHRMhkRtaTDilqBmPWoqasI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvimRoL8bsgOD4G0BO0EXgGrWOqNKvYmio7SCjcp8JkzNimsNG30WT3JrSDOrnUGAZAEec7DKNLGSkL7ZJuxbiRvsyheZPjzcN2kLpSVhbxtK9Bj5yn1Fqq2CJaY3DaQgQwrUaWsn9sGqX5nVpGnhyqQsCxHKLiclOVmSKN/BTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=gHL5GTfN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8besaRg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 807771380394;
	Wed, 18 Jun 2025 09:23:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 18 Jun 2025 09:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750252986;
	 x=1750339386; bh=cJqYrty+ZCMQ9sMd6DPBbLgOpbJYrAg1hXA8IjpBTWk=; b=
	gHL5GTfNzLDptWVxtr0Y6oX56/26YLLnItwE3GvmRTaalQjxapjQczosl3/96mGF
	blQ1b3h4yYdOfJix/c+MxR3QtcmjeohqHqYjeRBqvXS88Ce71JQbu5te5OuGqHCO
	bWny9g6YFPL7EIFtMS+gerQpEDFe9jzZyZ0OWxmIANAkL8b+ptAEfKKzT3Qsrnup
	6EZ9AzhPMIC/pScsmEnJtGa0/7HbthLGs40/J+FjF5NdM1yjRnd0A4tzT2pfZ/Mb
	VIiIORmmEcdhTLEFZN9QOU3oUhQJexzxK/yrywzdX6zJ5BYGYx2ch2CGCIRfTFsD
	VbK0mBiufyoLiTj3q0rGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750252986; x=1750339386; bh=cJqYrty+ZCMQ9sMd6DPBbLgOpbJYrAg1hXA
	8IjpBTWk=; b=A8besaRgu5Ygp0FM/TSGA32km4RdyD5eqlAmdnMBx0tyHw1s//A
	r4txev+iTlMED9ehgGkilgSLkEC8kn4Du3vica4+xjBK5KeUbMmrSGo6VATkLdSu
	BtiC2VVD2uSuFOykRuK2jwf5yEIWLgDY7KNh88hTpvu+ooQ/DhxbCr+M8qOOinrT
	hJ3+DJdMyuhK7p+C/EPf17PYDl72maTQiIOGVdA7zgIuMWyTFO1fZ8QmF4IC9D0U
	06QasTKP3IXrGfOUbCRP9L6tMzA7nDhMoDd2qI0RufCvlK+MddFvWduytyoWybeL
	Wr4xxdZ1OwX6Rf/tmP+og0TxQBxno9by/8w==
X-ME-Sender: <xms:ub1SaLXPb_mlJsjlZuznwT7Jmjz3kgE056QYLHo8KOpxVwhdjVJAcg>
    <xme:ub1SaDkqCmLYk5MkEfwrBar_dfDseBe7yZYjKCGeNCJFLbrMHjfetKNkh-YVnZi9x
    HrlV0gDOOib3A>
X-ME-Received: <xmr:ub1SaHaILzJfgnrooryIXEaXrGu7gi53sj9iVvSsLl1YFHeMYlTNC4aUZa-LlA2wHYiz39DvBvGzbNxgglQZEmwfyz9hR46qaLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeen
    ucfhrhhomhepfdhmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhmfdcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgt
    ohhmqeenucggtffrrghtthgvrhhnpeekkeevieevkefhieetveehueekhedufeelgfevud
    ejkefhffehuddtjeegteehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehqihhugihurdiihhhuohesihhnthgvlhdrtghomhdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopehtohhnhidrlhhutghksehinhhtvghlrdgtohhm
    pdhrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdprhgtphhtthhope
    hmtghhvghhrggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrhhitgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvggurggtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ub1SaGWKgngI8yYe7ScJPCXjI5SaF0r8RL8h9gvYqqTzUHHzPEm38Q>
    <xmx:ub1SaFlvS_90qv-_WTmvxYhug3F9jngxx8XBUhpRENYgKzjQlGo6zQ>
    <xmx:ub1SaDf7Gs5DyAxF8WRWVl6BVjhsQKNL9yh3kIh5sBk0cM02_kK2lw>
    <xmx:ub1SaPHxgbozNZ5UrcnmmTdNZvjPf0ReG_R--jh1VwcgAFLmcRFMwA>
    <xmx:ur1SaNDYHNfs8Mnm1Goa5m9pr8lAWDo5FDjHiyW0f-MCzY6qTpAUeSF4>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 09:23:04 -0400 (EDT)
Date: Wed, 18 Jun 2025 15:23:02 +0200
From: "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Message-ID: <aFK9tnZOPtF2pa80@mail-itl>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
 <CY8PR11MB7134FA32BC293D5E868016A18972A@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aTKB59D1qi71zo/d"
Content-Disposition: inline
In-Reply-To: <CY8PR11MB7134FA32BC293D5E868016A18972A@CY8PR11MB7134.namprd11.prod.outlook.com>


--aTKB59D1qi71zo/d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Jun 2025 15:23:02 +0200
From: "marmarek@invisiblethingslab.com" <marmarek@invisiblethingslab.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference

On Wed, Jun 18, 2025 at 03:26:43AM +0000, Zhuo, Qiuxu wrote:
> Hi Marek,
>=20
> > From: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> > [...]
> > Subject: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
>=20
> Thank you for reporting this issue.=20
> Could you please test this patch on your machine to verify if it fixes th=
e issue?

I can confirm it works now, I have the "EDAC igen6: Expected 2 mcs, but only
1 detected" message and it doesn't crash anymore. Thanks!

Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--aTKB59D1qi71zo/d
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmhSvbYACgkQ24/THMrX
1yzzjAf5AUXowsoMKnMQkWMIwzyoBsS5h8NCJwz3O8C93ZqTdALF2L5Dk61Z9vx5
ugDBhHjt7Xi3SH0kRtMUuoXKwlTSvBZzAGzdNcYd58wOx7V7JMtVQZtFNQeWXyoR
hsZBxIDxyAUqhkyEuhKUhIXx8+LD+CTk3R+M/1sv5uDMallmd6BNyMQGQ6GUwyr7
Ui90PAA7S3QVCy+C3+jD1qUutDQ2njNGmWfeiniT9cSiyJhXJpFqw4oi1Y/dIKCW
Vse5M3NyHYiyKD92LEeYPDX0zv1ZhsTmC1X3fbjAJDjBhj+gPrs/Nx7LxK82QivG
EqJoSthckcao5Yn0jjFKHrni9v7mjw==
=EQ4E
-----END PGP SIGNATURE-----

--aTKB59D1qi71zo/d--

