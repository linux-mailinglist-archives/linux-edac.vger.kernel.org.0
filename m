Return-Path: <linux-edac+bounces-1397-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D55091A3D2
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B81C21289
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90A13E028;
	Thu, 27 Jun 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv2xBb7O"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5313DBBB;
	Thu, 27 Jun 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484298; cv=none; b=SNg43ulSIs3svDg8NhagmiDeD5JSB3v9XWQaWKX7rbaCTDOperK3N/KpGix+r29/LT2InhNphys2MWQzB2tx58at4s9QnHs+YDVnY92vhLZUnRuhq8vQC9AxbwngBPmtcprbrhMZEgAoZug1f0nRPSTBRJ5hv2HkQl56eX6N6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484298; c=relaxed/simple;
	bh=qpqUy25uSQ7umwQUpYeSX1RSX4gBl98eIbXikheTNFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6TP0NpIQapxpP5E97Qv0Wc300ReG+6tMQIauDUsGOCnf2DFWvLSjr4voyyMsAJXVvraeawOgydi3Uih1y7+T0USuNppjYz59xTc0iuwNhMhQQOjQQ4fsxuM9r/gEiMfIwA4g13r2RLtYRWzX/rAPalkXtHGH5eaXE6fMkIpbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv2xBb7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172EDC2BBFC;
	Thu, 27 Jun 2024 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484298;
	bh=qpqUy25uSQ7umwQUpYeSX1RSX4gBl98eIbXikheTNFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zv2xBb7OPFFHaHfZkW+DUCabkIOPFJR6MQyEIuJE+PXhkMweq2XkwiusA57QToNHs
	 mCZTnTnIPKy2hTs4SsiUA+FBg4PolOjwhxwjnLJWfZnhV+Lqp7dVLIOZggsxcVJJ4P
	 28kyjXDfAqoAQvsVnb7e3MeeSCTxyouPeU6tgf5YEANq+D/cYNlJb0UQBVLcVzgqRL
	 p+Pq2ykDYUd9xsXHRNjIuBJMgK7VTBmbSZmy0KyoDk/uu5U5xfmZz9MmpWgLIwAk93
	 z0z1hBkNG3DfcWgwdLEW8KLkedgJ7/LXv7+AGBo8+vDs0ZKJWbYCL8UwVco92biNbr
	 JLiuXBRXj4ZkA==
Date: Thu, 27 Jun 2024 12:31:31 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel Ferguson <danielf@os.amperecomputing.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, James Morse
 <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Len
 Brown <lenb@kernel.org>, Shengwei Luo <luoshengwei@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Tony Luck
 <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240627123131.39321114@coco.lan>
In-Reply-To: <20240627075034.GBZn0Zyj_3n8XnKOQm@fat_crate.local>
References: <cover.1719471257.git.mchehab+huawei@kernel.org>
	<95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>
	<20240627075034.GBZn0Zyj_3n8XnKOQm@fat_crate.local>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 27 Jun 2024 09:50:34 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Thu, Jun 27, 2024 at 09:01:08AM +0200, Mauro Carvalho Chehab wrote:
> > @@ -570,7 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_he=
st_generic_data *gdata,
> >  				    error_type);
> >  		p +=3D err_info->length;
> >  	}
> > -
> > +#endif
> >  	return queued; =20
>=20
> The previous version I saw, had it right. "queued" was outside the ifdeff=
ery:
>=20
> drivers/acpi/apei/ghes.c: In function =E2=80=98ghes_handle_arm_hw_error=
=E2=80=99:
> drivers/acpi/apei/ghes.c:575:16: error: =E2=80=98queued=E2=80=99 undeclar=
ed (first use in this function)
>   575 |         return queued;
>       |                ^~~~~~
> drivers/acpi/apei/ghes.c:575:16: note: each undeclared identifier is repo=
rted only once for each function it appears in
> drivers/acpi/apei/ghes.c:576:1: error: control reaches end of non-void fu=
nction [-Werror=3Dreturn-type]
>   576 | }
>       | ^
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:244: drivers/acpi/apei/ghes.o] Error=
 1
> make[4]: *** [scripts/Makefile.build:485: drivers/acpi/apei] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:485: drivers/acpi] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1934: .] Error 2
> make: *** [Makefile:240: __sub-make] Error 2


Sorry, bad conflict resolution during rebase. Will send a v2.


Thanks,
Mauro

