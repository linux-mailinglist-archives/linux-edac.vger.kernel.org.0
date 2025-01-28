Return-Path: <linux-edac+bounces-2953-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4267BA20BC5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2025 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F7F168334
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7CC1AAA1B;
	Tue, 28 Jan 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkpS2DGb"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFE19DF61
	for <linux-edac@vger.kernel.org>; Tue, 28 Jan 2025 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738073463; cv=none; b=I0w7XidX77utFeCdD0U6uvZmPZimpYkkN6dnRtUwThCujnz/2a3JUxJPXrqjTU/UUFvHziapJ4NKFbNAXHoiHDgiQKaPMkGNXJOz8N6GLzu2bOzab9k2keli1CRRHgeV0QBhe5SJIJ2vUqIhiaRtbwo7CAwygFuif35NgDNjQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738073463; c=relaxed/simple;
	bh=igNTPykygVNH6arma23Ph21GFB4mwNjy6q3tWjx0hys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSs6t1TinOUqjpMTKNqnDXgR5dRwsceWarS8+VYAMS4/vZU7YwhLsNadLdt4yyaayUEwbsLuysZQyX7ozSFfsatyWfF9WJzm18HfatJK/PS5P+6SxtQF6EGAHbVSwiDtIKbP+A1vYUn0WafaXjOoZtey6xPdm6H1Hupqu/4vdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkpS2DGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004C6C4CED3;
	Tue, 28 Jan 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738073462;
	bh=igNTPykygVNH6arma23Ph21GFB4mwNjy6q3tWjx0hys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkpS2DGbeyj4XNW7kiOSRA752iyX44bTB8XToUTM5w+mIIGHSFKfMGyuA90PM/meX
	 yJoqguVA/Iszmpi5PgUoDBEj3ZHSrsR1tbnvNZj0mMFUqd2QDh1Ju91xS8d7bD0Wdx
	 CyL6eoDyefnFlDGek5cte5nI74BJnskEjSH1fMZjeiUI9dq9T00wYTbnqRWBGZfQNK
	 86gYmYGpll8xezVO2BC9motCV76ISj+Ngqv1U3ApUdhFec0LcpKREIrRyX7oKQ3/m7
	 WpBrXyp9NX/gFtastXC+hWtrUBEZ67QKnZcrhGwpC96Kt4mmNhVsOSL5DSbPIneR2g
	 +C38sqnBixjQQ==
Date: Tue, 28 Jan 2025 15:10:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Matthew Emerson <Matthew.Emerson@ibm.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: RASDaemon patch
Message-ID: <20250128151058.0bcf49a4@foz.lan>
In-Reply-To: <BL1PR15MB5337303B199FE97F5B005884E6EF2@BL1PR15MB5337.namprd15.prod.outlook.com>
References: <BL1PR15MB5337303B199FE97F5B005884E6EF2@BL1PR15MB5337.namprd15.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 28 Jan 2025 11:19:45 +0000
Matthew Emerson <Matthew.Emerson@ibm.com> escreveu:

> Hi,
>=20
> I=E2=80=99m a developer at IBM working on the storage systems range, I am=
 working on using RASDaemon as a method to help manage correctable errors i=
n DIMMs, and I was hoping to talk to you about a patch I was intending to s=
ubmit.
>=20
> Essentially, I was hoping to submit a patch which will have the trigger f=
eature work when the threshold is exceeded rather than when any event occur=
s. As I am looking for more to happen than offline the page via soft or har=
d offline when the threshold is exceeded, and it would be beneficial to hav=
e a custom script trigger.

Triggering with thresholds makes sense. Yet, as the event trigger starts=20
an script, it would be possible to use it to check for thresholds inside
the script itself. Not sure what would be the benefit to embed the event
threshold calculus inside rasdaemon. Granted, it can query the database to
better detect thresholds.

On that sense, one thing that I'm considering is to extend the DB interface
for it to work with other databases (MariaDB/MySQL, Postgres,...) and have=
=20
a better data model to help taking such policy decisions. Patches to
take such approach are welcomed.

Yet, if you have something already coded, please send a PR to github.
I'll review there. You may also open an issue for us to discuss it there
and keep track of its progress.

> I wanted to know whether this would be something you would consider accep=
ting into the codebase? As I have something working and tested right now. I=
f you were I also wanted to know roughly how long the process would take un=
til merging?

It very much depends on how much time I have to take a look on userspace
code. I'm intending to review a bunch of pending stuff maybe next week
or at the week after that.

> Please get back to me as soon as possible.
>
> Kind regards,
>=20
> Matt
>=20
> Unless otherwise stated above:
>=20
> IBM United Kingdom Limited
> Registered in England and Wales with number 741598
> Registered office: Building C, IBM Hursley Office, Hursley Park Road, Win=
chester, Hampshire SO21 2JN



Thanks,
Mauro

