Return-Path: <linux-edac+bounces-69-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7EF7F2070
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 23:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8A4B2189B
	for <lists+linux-edac@lfdr.de>; Mon, 20 Nov 2023 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2536B0E;
	Mon, 20 Nov 2023 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dg1hNBY0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08863A2;
	Mon, 20 Nov 2023 14:37:42 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A8FC40E0031;
	Mon, 20 Nov 2023 22:37:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Qlr3bOPqbg-W; Mon, 20 Nov 2023 22:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1700519856; bh=x9IsRR5+1IkHxb6g4ZF6VKh5RWuwsZ6e/RDXJfhFiD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dg1hNBY0wesA8gF8gY062vLM00Xkf87s/irWgAp0+1T2yNZoU2eVnkYYyVrxkfpHz
	 v/CDNxZDsCqarhLXL027s+pfyo+cb00NQ+heMcdDK5qHf4eCmwP5AC8Ko4XXrEvh0h
	 qy5WiIgPjMvMtCy9MzPe9CYO9L00hoz00Ae8YDNpQaCpMJbiDtn3ldGtOYWTHCJcOd
	 POUfqOEZmCTk+RCnJetbB71ya+N0vBNuO4UOEIjbyEAX7/qMJhNBUyhUeOKBaWpdr9
	 YXlgbmJesULfeTbywn5O1jZW+CDsSN28Moe7bkZurTMsNjeVqFfIeDunus09ODlB+9
	 fEfyLgKfgFGkHZ6pJpHYRJey0eezKUVcZ8Qc59gKQ92a1zr76WREbMpAypqCcPtj97
	 vg1YoUfOfTbsDQ+D2jCCoGLNi+iEV1PzyzEn3Z73VmCGWfY4BbSsFShjd77tGlbqKQ
	 izFw8wSSMT1BGhfp+Ro1kCZ/D2RdiArgVse5ESOch3H+PRJc2DiRB/eSKimWYc0Imc
	 51ftFCVoExnkhJIHP6oIv23Ozazu8LiNp7aCnA5yDl3BAJl0GeAJMZXNjZcEFeADub
	 rKKadA08E2hrF5E+9USWuVi6IRhECjsE9szf2Lan9eZJvUIChphm7NPyJeVdCD+kcQ
	 vrlIcs/4QTTXJRxGHEKkBd/w=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC2FE40E01AD;
	Mon, 20 Nov 2023 22:36:56 +0000 (UTC)
Date: Mon, 20 Nov 2023 23:36:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Luck <tony.luck@intel.com>, Dinh Nguyen <dinguyen@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	kernel@pengutronix.de, Jan Luebbe <jlu@pengutronix.de>,
	Stefan Schaeckeler <sschaeck@cisco.com>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	Shravan Kumar Ramani <shravankr@nvidia.com>,
	Lei Wang <lewan@microsoft.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Marvin Lin <kflin@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>,
	openbmc@lists.ozlabs.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Tero Kristo <kristo@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH 00/21] EDAC: Convert to platform remove callback
 returning void
Message-ID: <20231120223651.GIZVvfg1amJyXdmYKQ@fat_crate.local>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 03:12:33PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Uwe Kleine-K=C3=B6nig (21):
>   EDAC/altera: Convert to platform remove callback returning void
>   EDAC/armada_xp: Convert to platform remove callback returning void
>   EDAC/aspeed: Convert to platform remove callback returning void
>   EDAC/bluefield: Convert to platform remove callback returning void
>   EDAC/cell: Convert to platform remove callback returning void
>   EDAC/cpc925: Convert to platform remove callback returning void
>   EDAC/dmc520: Convert to platform remove callback returning void
>   EDAC/highbank_l2: Convert to platform remove callback returning void
>   EDAC/highbank_mc: Convert to platform remove callback returning void
>   EDAC/mpc85xx: Convert to platform remove callback returning void
>   EDAC/npcm: Convert to platform remove callback returning void
>   EDAC/octeon-l2c: Convert to platform remove callback returning void
>   EDAC/octeon-lmc: Convert to platform remove callback returning void
>   EDAC/octeon-pc: Convert to platform remove callback returning void
>   EDAC/octeon-pci: Convert to platform remove callback returning void
>   EDAC/ppc4xx: Convert to platform remove callback returning void
>   EDAC/qcom: Convert to platform remove callback returning void
>   EDAC/synopsys: Convert to platform remove callback returning void
>   EDAC/ti: Convert to platform remove callback returning void
>   EDAC/xgene: Convert to platform remove callback returning void
>   EDAC/zynqmp: Convert to platform remove callback returning void

All applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

