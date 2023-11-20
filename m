Return-Path: <linux-edac+bounces-67-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F37F1B49
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766711C21049
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004A224E2;
	Mon, 20 Nov 2023 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-edac@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA99139
	for <linux-edac@vger.kernel.org>; Mon, 20 Nov 2023 09:45:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FFD1042;
	Mon, 20 Nov 2023 09:46:02 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E710F3F7A6;
	Mon, 20 Nov 2023 09:45:14 -0800 (PST)
Date: Mon, 20 Nov 2023 17:45:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James
 Morse <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH 09/21] EDAC/highbank_mc: Convert to platform remove
 callback returning void
Message-ID: <20231120174512.055f1dda@donnerap.manchester.arm.com>
In-Reply-To: <20231004131254.2673842-10-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
	<20231004131254.2673842-10-u.kleine-koenig@pengutronix.de>
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

On Wed,  4 Oct 2023 15:12:42 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

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
>  drivers/edac/highbank_mc_edac.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_e=
dac.c
> index a0c04a7f95e9..1c5b888ab11d 100644
> --- a/drivers/edac/highbank_mc_edac.c
> +++ b/drivers/edac/highbank_mc_edac.c
> @@ -251,18 +251,17 @@ static int highbank_mc_probe(struct platform_device=
 *pdev)
>  	return res;
>  }
> =20
> -static int highbank_mc_remove(struct platform_device *pdev)
> +static void highbank_mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> =20
>  	edac_mc_del_mc(&pdev->dev);
>  	edac_mc_free(mci);
> -	return 0;
>  }
> =20
>  static struct platform_driver highbank_mc_edac_driver =3D {
>  	.probe =3D highbank_mc_probe,
> -	.remove =3D highbank_mc_remove,
> +	.remove_new =3D highbank_mc_remove,
>  	.driver =3D {
>  		.name =3D "hb_mc_edac",
>  		.of_match_table =3D hb_ddr_ctrl_of_match,


