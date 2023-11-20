Return-Path: <linux-edac+bounces-68-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1FE7F1B4A
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 18:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF691F255D9
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F6225D6;
	Mon, 20 Nov 2023 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-edac@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F2010E
	for <linux-edac@vger.kernel.org>; Mon, 20 Nov 2023 09:45:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FDF11692;
	Mon, 20 Nov 2023 09:46:10 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9FC3F7A6;
	Mon, 20 Nov 2023 09:45:22 -0800 (PST)
Date: Mon, 20 Nov 2023 17:45:20 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH 08/21] EDAC/highbank_l2: Convert to platform remove
 callback returning void
Message-ID: <20231120174520.18865e87@donnerap.manchester.arm.com>
In-Reply-To: <20231004131254.2673842-9-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
	<20231004131254.2673842-9-u.kleine-koenig@pengutronix.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Oct 2023 15:12:41 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

Hi,

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/edac/highbank_l2_edac.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_e=
dac.c
> index 140d4431bd0d..5646c049a934 100644
> --- a/drivers/edac/highbank_l2_edac.c
> +++ b/drivers/edac/highbank_l2_edac.c
> @@ -118,18 +118,17 @@ static int highbank_l2_err_probe(struct platform_de=
vice *pdev)
>  	return res;
>  }
> =20
> -static int highbank_l2_err_remove(struct platform_device *pdev)
> +static void highbank_l2_err_remove(struct platform_device *pdev)
>  {
>  	struct edac_device_ctl_info *dci =3D platform_get_drvdata(pdev);
> =20
>  	edac_device_del_device(&pdev->dev);
>  	edac_device_free_ctl_info(dci);
> -	return 0;
>  }
> =20
>  static struct platform_driver highbank_l2_edac_driver =3D {
>  	.probe =3D highbank_l2_err_probe,
> -	.remove =3D highbank_l2_err_remove,
> +	.remove_new =3D highbank_l2_err_remove,
>  	.driver =3D {
>  		.name =3D "hb_l2_edac",
>  		.of_match_table =3D hb_l2_err_of_match,


