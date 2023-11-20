Return-Path: <linux-edac+bounces-65-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587047F1886
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E7A1C21868
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F11E508;
	Mon, 20 Nov 2023 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-edac@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E1093
	for <linux-edac@vger.kernel.org>; Mon, 20 Nov 2023 08:22:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r571A-0004hc-4H; Mon, 20 Nov 2023 17:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5715-00AOMM-7d; Mon, 20 Nov 2023 17:20:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5714-004V52-S7; Mon, 20 Nov 2023 17:20:54 +0100
Date: Mon, 20 Nov 2023 17:20:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>, linux-aspeed@lists.ozlabs.org,
	Tali Perry <tali.perry1@gmail.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Dinh Nguyen <dinguyen@kernel.org>, openbmc@lists.ozlabs.org,
	Nancy Yuen <yuenn@google.com>, Andy Gross <agross@kernel.org>,
	Joel Stanley <joel@jms.id.au>, linux-arm-msm@vger.kernel.org,
	Stanley Chu <yschu@nuvoton.com>, Robert Richter <rric@kernel.org>,
	Jan Luebbe <jlu@pengutronix.de>,
	Shravan Kumar Ramani <shravankr@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Tero Kristo <kristo@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Patrick Venture <venture@google.com>,
	Bjorn Andersson <andersson@kernel.org>, linux-mips@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Jeffery <andrew@aj.id.au>, James Morse <james.morse@arm.com>,
	kernel@pengutronix.de, Lei Wang <lewan@microsoft.com>,
	Stefan Schaeckeler <sschaeck@cisco.com>,
	Marvin Lin <kflin@nuvoton.com>
Subject: Re: [PATCH 00/21] EDAC: Convert to platform remove callback
 returning void
Message-ID: <20231120162054.haryuye4qedlfd7j@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdo7vk2aw267ud5x"
Content-Disposition: inline
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org


--bdo7vk2aw267ud5x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Boris, hello Tony,

On Wed, Oct 04, 2023 at 03:12:33PM +0200, Uwe Kleine-K=F6nig wrote:
> this series converts all platform drivers below drivers/edac to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side. However none of the edac drivers suffered from the easy
> to make bug, so all drivers are converted in a trivial way.
>=20
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>=20
> The patch for npcm was already sent back in June
> (https://lore.kernel.org/linux-edac/20230628071354.665300-1-u.kleine-koen=
ig@pengutronix.de)
> but didn't result in enthusiastic review comments and it wasn't picked
> up.
>=20
> There are no interdependencies between the patches. As there are still
> quite a few drivers to convert, I'm happy about every patch that makes
> it in. So even if there is a merge conflict with one patch until you
> apply, please apply the remainder of this series anyhow. I'll come back
> to the part that you (maybe) skipped at a later point.

Any news on this series? Would a resend help?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bdo7vk2aw267ud5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVbh2UACgkQj4D7WH0S
/k6t1gf+IirGoYLuqK5VC0fzJxyTYO4mc7qBgbuVM3P88Pu7qVConC4mkUSNPgCW
a7DFKrJNIsbwS61Eghc30hxINTLVzt+m50w6+m2eY4Crm6LkSu18fuweiDte3B8B
ECiAFB0EvPbNR8tv4Javms5+AKRVP5bAdREtoIeRWgFglceoVXOx/6NB//OwwPDp
1owt4JZbVUJH0axsnyKBzt5PMXyo3thq6Y7eTqQIjikbEvBA9tvA3PN51btMbJsO
6ttXmOnx7UO99+rXeL6VaKUzyRPTVvJxR3O70xJA36pnmSwm4oJ/LCcN/vX2kZpb
TeEQgFrvHjNBLraJcD3rqO+wNIxdXQ==
=WE4E
-----END PGP SIGNATURE-----

--bdo7vk2aw267ud5x--

