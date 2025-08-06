Return-Path: <linux-edac+bounces-4526-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E597B1C222
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3404E18C12CD
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8DB2264B2;
	Wed,  6 Aug 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNr+Xe3P"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECD92222C3
	for <linux-edac@vger.kernel.org>; Wed,  6 Aug 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468838; cv=none; b=et9efNNnKSVl/XtO1pUQQDeKJrkqqdsCGZ9cSxu534uZzahA19EYWlyHm0IcoHut5W0nscVfJhVOoYMsY0cOgX6Z7tGjjLmhkIpwHJ+PvS1C6pZiM/f8WrN7B+uaAqdH7BwByM4wgeSknsXf9RlyyaQxoZuaBoGHulKTmB0yRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468838; c=relaxed/simple;
	bh=gmyJ8RabFn6os9+4V23ofdCpWBEqn90tf8Noyt/OuyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbZmVdnW0Nzv9dQqF/0BDVwojCphcA5lMiZlaSMC7647ufXP3f20K3HJpOPfdXolgbdldRKmnj8tU8rLS/EMRKU7FEhIlq13Q2Oa3uf0GSeNrseVFUUzrAxEmoaFiK8R/yAYgUwKpa/v3BPMEjAwLaPXy81qZI/B8x26MNCQaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNr+Xe3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497ADC4AF09;
	Wed,  6 Aug 2025 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754468838;
	bh=gmyJ8RabFn6os9+4V23ofdCpWBEqn90tf8Noyt/OuyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cNr+Xe3P9o7MyakbEXHCOLXnqyAvdwzmb74JESotvhKz/+jrIhDfB3msDg4xna8c9
	 hEJQy7RZz+MW8dSKSZSmrsMZUcMqU6mMADD/0jz2FoqRL7wKqPzXBgodo+bnMvU5Q3
	 bUOO1S3T4747XVUpD29axHsolwuN7QHkA0EEuMzLOSOY1o6t1SxgD17HXFAjfhggeJ
	 7pckEnpCNDKKc6HsBGgBipZesluymeaMRrR+0dsnrPu7/mOb/jxDqHpkFAUrr/Ogwn
	 VtXojvH5xf8x78a3P6S2Iws++NYlSi8v2vKiLjnGB1y+YiC+5uPCcgJiU8HVAXGBSG
	 oUytVtRo/8t2g==
Date: Wed, 6 Aug 2025 10:27:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Samaresh Singh <samaresh.s@partner.samsung.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: Coredump detected executing rasdaemon 0.8.3 using "rasdaemon -f
 -r" on host with AMD CPU with Ubuntu 24
Message-ID: <20250806102714.03aaf0bb@foz.lan>
In-Reply-To: <8eaa91e233aa40aa9a3d9737313661b7@partner.samsung.com>
References: <CGME20250805214451uscas1p25185f82c64c5519e601f4645044e0b86@uscas1p2.samsung.com>
	<8eaa91e233aa40aa9a3d9737313661b7@partner.samsung.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 5 Aug 2025 21:44:50 +0000
Samaresh Singh <samaresh.s@partner.samsung.com> escreveu:

> Hi,
>=20
>   I compiled rasdaemon 0.8.3 using the code at https://github.com/mchehab=
/rasdaemon/ on a machine with AMD CPUs and Ubuntu 24 as OS. =20
> The details about the CPU is available as:
> +++
> processor            : 167
> vendor_id            : AuthenticAMD
> cpu family           : 25
> model                   : 17
> model name       : AMD EPYC 9634 84-Core Processor
> stepping              : 1
> microcode           : 0xa101148
> cpu MHz                             : 1500.000
> cache size            : 1024 KB
> physical id           : 0
> siblings : 168
> core id                  : 78
> cpu cores             : 84
> apicid                   : 157
> initial apicid        : 157
> fpu                         : yes
> fpu_exception    : yes
> cpuid level          : 16
> wp                         : yes
>=20
> root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# uname -a
> Linux msl-ssg-cx02.msl.lab 6.8.0-71-generic #71-Ubuntu SMP PREEMPT_DYNAMI=
C Tue Jul 22 16:52:38 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# cat /etc/lsb-release=20
> DISTRIB_ID=3DUbuntu
> DISTRIB_RELEASE=3D24.04
> DISTRIB_CODENAME=3Dnoble
> DISTRIB_DESCRIPTION=3D"Ubuntu 24.04.1 LTS"
> +++++
>  =20
> I had installed all the required dependencies and configure using "-enabl=
e-sqlite3 -enable-aer -enable-mce".  The compilation succeeded without any =
errors/warnings but when I tried executing using the command "rasdaemon -f =
-r" I got the coredump as shown below:
> +++
> root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# rasdaemon --version
> rasdaemon 0.8.3
> root@msl-ssg-cx02:/usr/local/var/lib/rasdaemon# rasdaemon -f -r
> *** buffer overflow detected ***: terminated
> Aborted (core dumped)
> ++++
>=20
> Has this been reported by other folks?=20

Tha=C2=B4t s new to me.


> Can you please look into this and let us know what could be causing this?=
 =20
> If you have already observed it, are there any plans to provide a fix for=
 this issue?

You need to use the core dump to identify what line of code caused
the issue. If your machine is using systemd, there is an utility
(coredumpctl) that allows you to inspect it. There is a description
about how to do it at:=20

https://wiki.archlinux.org/title/Core_dump

Once you check the source, I suggest you to take a look at the code
if it belongs to rasdaemon. If it came from some other place, e.g.
from one of rasdaemon dependencies, then you may need to open a bug
to the specific package on Ubuntu, if rasdaemon is passing the data
right to it.

Regards,
Mauro

>=20
> Hope to hear soon.
>=20
> Sincerely
> Samaresh K. Singh
> Memory Solutions Lab Team
> Samsung



Thanks,
Mauro

