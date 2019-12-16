Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BC1204A5
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLPMBx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 07:01:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfLPMBx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Dec 2019 07:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QCchVxwhDIlyJ8ge76Gr1ecOebbrwILZYooDEBWLIGc=; b=eh1DnYImVtZ9r4XF5/1qMxyHy
        J7GWZy00VzyNVtffmTNC+Fuo8vAi4Z+maSSwE9pBk5NIDLiqVbt/uL6pxi9VCyoJm4jqX0GtZ99Fy
        6vDuyXZZpYRd9jcKOHCbNIUl62Rn8eqW194U7q7rFlTZw3I36JUl01YAwlQju3uLWD7CKINlq4Xwt
        ww9wgbMqzNj0OOSL+Bk1v9xzTu6qo7xcRya3nIqq+elQj/F+jwn3+BxQ8SmChXIxTOvsMG58KjL/K
        hN7WfBHITznikQJSR0GszRKFQZlIwSepmfrlp/E6ysU5gksy757cI1rlqWVUytUdAgfDVyWtG+4S8
        PcXisK1pw==;
Received: from x2f7f823.dyn.telefonica.de ([2.247.248.35] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igp4B-0000TG-A4; Mon, 16 Dec 2019 12:01:35 +0000
Date:   Mon, 16 Dec 2019 13:01:30 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rrichter@marvell.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] EDAC: remove set but not used variable 'ecc_loc'
Message-ID: <20191216130130.1d7ff030@kernel.org>
In-Reply-To: <20191216110121.46698-1-yukuai3@huawei.com>
References: <20191216110121.46698-1-yukuai3@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Mon, 16 Dec 2019 19:01:21 +0800
yu kuai <yukuai3@huawei.com> escreveu:

> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/edac/i5100_edac.c: In function =E2=80=98i5100_read_log=E2=80=99:
> drivers/edac/i5100_edac.c:489:11: warning: variable =E2=80=98ecc_loc=E2=
=80=99
> set but not used [-Wunused-but-set-variable]
>=20
> It is never used, and so can be removed.
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
> changes in V2
> -remove the definition of the function i5100_redmemb_ecc_locator()

Sounds ok on my eyes.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>  drivers/edac/i5100_edac.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index 0ddc41e47a96..191aa7c19ded 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -259,11 +259,6 @@ static inline u32 i5100_nrecmemb_ras(u32 a)
>  	return a & ((1 << 16) - 1);
>  }
> =20
> -static inline u32 i5100_redmemb_ecc_locator(u32 a)
> -{
> -	return a & ((1 << 18) - 1);
> -}
> -
>  static inline u32 i5100_recmema_merr(u32 a)
>  {
>  	return i5100_nrecmema_merr(a);
> @@ -486,7 +481,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, =
int chan,
>  	u32 dw;
>  	u32 dw2;
>  	unsigned syndrome =3D 0;
> -	unsigned ecc_loc =3D 0;
>  	unsigned merr;
>  	unsigned bank;
>  	unsigned rank;
> @@ -499,7 +493,6 @@ static void i5100_read_log(struct mem_ctl_info *mci, =
int chan,
>  		pci_read_config_dword(pdev, I5100_REDMEMA, &dw2);
>  		syndrome =3D dw2;
>  		pci_read_config_dword(pdev, I5100_REDMEMB, &dw2);
> -		ecc_loc =3D i5100_redmemb_ecc_locator(dw2);
>  	}
> =20
>  	if (i5100_validlog_recmemvalid(dw)) {




Cheers,
Mauro
