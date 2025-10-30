Return-Path: <linux-edac+bounces-5262-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8DC1F8E7
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 11:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9091F34DFFB
	for <lists+linux-edac@lfdr.de>; Thu, 30 Oct 2025 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3A351FA1;
	Thu, 30 Oct 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgc+lJkM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F734D91B;
	Thu, 30 Oct 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820247; cv=fail; b=KHCgmeSBrluGJt66MT3OLA1v1c29b7u03OykW2rsi8NMt29k4ciqyxSJvXJMKzmBSG0mZ99Qbkv4/ML4bEPZ0dM7xPfjaNlgIWWL8HwrQvfz/bzCsl6lxr6im/QKX+s7E5xjNveYidKPOqERJ0drX/li0+A7zGglO4IEW1G7uf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820247; c=relaxed/simple;
	bh=N/WYRvLbovWo0+NRm/Zcx4EwB3YdLshXwZ78h6MRDI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YfubpjXwmm0uAJRWqR2vvHx2uATF2JFTxVPMFoMk1LMq6f8xDs+tN8rObHY+u0Vqg74n26JcHzT0z/HFrWEzHF5BaKFYs7vRCijGrB5UYyW7B2V2KVVLYt1chH1voQLOQ26OX1AiI4Oqw2qrGKJGzsGxIc8eQsk27aA0q0TVZc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgc+lJkM; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761820245; x=1793356245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N/WYRvLbovWo0+NRm/Zcx4EwB3YdLshXwZ78h6MRDI0=;
  b=bgc+lJkMMAQTCrrTfcOoS2f3JTVtljArkWdwOX7GSTCsiXWnJXqIvMRr
   oCNFGtC33+eWDZgQ++pEAEiIRE0jSQVBViPuYTw+r6DKatDRa7N/BZLIK
   +wuATuUpgwHFQqdtgYwwgZbI7UtugcCDIezza4W6kj1MN5BzthpzScG0t
   5DHIVlT0e/A4TfI3E+zSJ10Yg3I7T3nJlzy5eJ9wy5d4KXLS460RqsnPg
   y2hq/uVpnGXJ+Q/RfcnVvwCJlUTShFvzKR+X3Bpw7E7OltkPVmk3SsMOQ
   kJnHyRZhlmamgkSC96CzWABsbnPXd+DQkMLHBEDN1oSUmbogTTEzxwDO8
   A==;
X-CSE-ConnectionGUID: o7GRMUWsRg+C1qJ5stVSEA==
X-CSE-MsgGUID: y7ckO4zJRMCucxH+MzkmHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67818566"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="67818566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:30:44 -0700
X-CSE-ConnectionGUID: enQD6uq2RLGyVCJGNF7uaQ==
X-CSE-MsgGUID: qbRuw4rLSNaLN6L1PpqaeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="191085081"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:30:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:30:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 03:30:40 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 03:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFb7JZFJjRw79RDo9QRd0RyZ1LsoY8M94USrKg2honNQM1epeU3lutlnFhjE+QvdfPO2A4oYkezmTOs/ZE/ONYd5FzkDkscdQSOF5ZNyEkjzUzXam+TFPQC9iYhltLbnc9g0ZgwKlSa02EDVCnoBr+miqhwAVkL0JLYdiXgjq8HI3MJp3405E6uBcnykwz0UmRBzs0TbOFqDwddTtQJd/VI/fqLNL6s21mzICm+KDRIS8geXYIhj93A5o32J8xrlZ1nsWDImveAUp0QaEGpCSbWvRDAocPZVNhxrplckpirIjuYoiowBYcA7j/WRdkO6BnNaTzimxhg29u05AdaWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp3nWXldXyPIFcyyAIdlcg/FRYRuT4cwPUMx4rPHQUM=;
 b=pHaWBwNC22twTWRlcoA/xpqnmJQu8weyMkNwDumH0n/279lIW9obpoVkubXUFTM2z0oWg8JN4PP06crxJmSy58RXYLLv74pcgfsqgqQP9oUyn06ZYuv/ccVzoGO1ko835J2gviv90VwX/odRtt3BVa8wbiN6t14oc7ZbRcLKmPdNy1+CIec19zGylBQ5vAw/w9T+K+ZxUEmYx1b+0ap0L/IQGu9l+feFyQ0iy/Y9bdNIJTBFWhfAPBWQjJ2TfUNohwdASpsSvMG4S2ednvoVKR2gHUPvKuGksIyLeLyZV02wf2UtL2AgZAzyIlP1r7oDhjmn527125J1AMnAj+A+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 10:30:37 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 10:30:37 +0000
Date: Thu, 30 Oct 2025 10:30:24 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky
 Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>, "Vincent
 Mailhol" <mailhol.vincent@wanadoo.fr>, Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Kim Seer Paller
	<kimseer.paller@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, "Cosmin
 Tanislav" <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<qat-linux@intel.com>, <linux-gpio@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-iio@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/23] crypto: qat - #undef field_get() before local
 definition
Message-ID: <aQM+QPi7KqN8Nuu6@gcabiddu-mobl.ger.corp.intel.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <ef5c6bfcdf08892fa09cc4aaec5ef49067201195.1761588465.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef5c6bfcdf08892fa09cc4aaec5ef49067201195.1761588465.git.geert+renesas@glider.be>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU6P191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::28) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: 323b1021-3683-4a92-53f0-08de179f5dbe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+joMZIf8WTPtJER/IF7laoPKB3uRK/f0oqBUVPY4R3s/JIyqlNWTMmp5Y1Q?=
 =?us-ascii?Q?VxBedB5CfvOPGwE0PyqokYhOYe+8ids8Y6wEH/oXF6xVTAAw224obRDd2y0g?=
 =?us-ascii?Q?tNG/pmwsNni/qMln1L7IhjmgSF3n5B5dCynZHjBj9t76FIrXLkmY4BRvU3PD?=
 =?us-ascii?Q?FYPSOJKUcxH44nZ0BRL7kkKSrNtKWBwPXQgN5qWrROZ8lobXWlg1G2/1U3+n?=
 =?us-ascii?Q?wBDRWHOSvvXaB6gxkbAv9Wd256aD1976BpyzFEbXkesRwlSqZoZ3aAnxXPRf?=
 =?us-ascii?Q?EOHapPrQR6dXK6x7z7kKu8aEIo8rEcCnWavDZEbBEvbmgdipShFy9T8OvwIo?=
 =?us-ascii?Q?GiwuWs26TMd2l6I/hBnfgf0AiSQAlLG1eZBB3XLoy/UoUE6VwwXGUAWsk6Ee?=
 =?us-ascii?Q?dzDOy/MJtctYCR7hobiyqrsKLoe58Mb0A4zDPMJ+GaI098OyfWuM+pA1R3C/?=
 =?us-ascii?Q?4xuUyeK71aJGVOaDrepWq71wggZEbezQYoqbzFxurQgprP+yfvipqeJ16B7j?=
 =?us-ascii?Q?XGQ4EocLV793cAbxuzUsXJrgb78DgGSgiQKWlBG1ggSZIaGy0hPntfoopv35?=
 =?us-ascii?Q?27DM4rr0HfEvwVXMVkXXw5F4ojH6qgrLd2vq5SWVaIscHDKorp0vhN5RgjVZ?=
 =?us-ascii?Q?jT9eMRcOIOxUZnkXZM+R3jygMYhGngvYV1BwPs0+GwM0Y4I68FMKA6lT1ixo?=
 =?us-ascii?Q?9FY6Ty0fuOkjMfw4czl1surspmRB90oGoMT2qO52gAwP3jjIOrIpBgCi1g0b?=
 =?us-ascii?Q?iv+9fP7eXj6oxKcpc+go8vrQu+U8dzsQoMRRRlHgJSiSo7QyIdPflmGrU+GQ?=
 =?us-ascii?Q?k8YWXtxPUxcvsM2N/oapI/DpE8kCK1P7xXgdGdV6PgwgQSi/geRlznpfQ4sq?=
 =?us-ascii?Q?fNAxfRm2f/hymT+ep2IdXryOE4Yj3rJOKb1MW26E1Pg94VqOzcL0cxJi/Alt?=
 =?us-ascii?Q?A3aAJSfGJAgPUk5j6AgX6A4wo3BcaalUlHoUvq8M3Hqdlo3dL8TmkvuHiVJC?=
 =?us-ascii?Q?NNb4NY0vK+99NLP0huMm3Uw/rFT6hLJY4B10v7L9E+cUK4Yuq9MxQzsecz30?=
 =?us-ascii?Q?0nwPFNgz0mH86P2lk00zMqf9z+pcZCqakBiVQ8Lo6fpEvwPdMGxJKZeHzQOT?=
 =?us-ascii?Q?mcWobCRpsCTnEpC5zgOVZ6xCfUjeEtVqiDfcsR6T7JReOXUrnPaVe0y5qQqf?=
 =?us-ascii?Q?xzIhy0nmUHVVzfGLYBflfpvoaDI2FP+MpwyuTJrKprNPFpkdJ1G/9SI0yi+G?=
 =?us-ascii?Q?w2AUidjYQYDumFbv0QMq4rAc6+zLR+9F4I7HPuaBKQo0+xl3xY/jMwfnLu9H?=
 =?us-ascii?Q?IhMmsgPA/tW6YegLh5eZKal1S7E079a9sOh2lEolVm2qDFjt+xDznBlCTfSb?=
 =?us-ascii?Q?lA7ZrFYdkweaJfSrnHSUUsICjIMQgDMvNnnwt49WAvZ2B4G2y29Zhi4ntO3M?=
 =?us-ascii?Q?8Qr/VRl9iAggCKBXao7WVwjMMeGmbC00?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkb3LVH8q1iZX6LZS7U+RIYWZE7wy5yxbZvdt4ob0d3+09x3N9YBY7i/SmmJ?=
 =?us-ascii?Q?wzFrqmBebyFdP21qus5P9hVjGYbmxlO7JGzZIwn3F4y5vH4QPIU6C3LbJkbS?=
 =?us-ascii?Q?Drc2jNsh4NL1YzVxfFjdA+OFsfIQOLgpW1qA6CDiaRMukR21WcDnIJFkrmxj?=
 =?us-ascii?Q?AxURKcn8zh+PJpJWuyl02FV6QTx25iLFuz8FbM4fdXfkiVEJRYRbbk7hSZK3?=
 =?us-ascii?Q?FsSSNrvmQTAy4J7ArQ/gGR1bXbK7wxuBkY5XeCNyk1g2J808o2IxRW6tt7ij?=
 =?us-ascii?Q?grxdsve0bjToD1SbppNkgS/S0vluGrE2i23IAEUt4OaJmcStx4d1QL/SJyVN?=
 =?us-ascii?Q?l8mlNuFv19VLcrE6vxMLvOhSfl/ltXda0QqXjNZuAWRo+zSWu0g3xfyefaDj?=
 =?us-ascii?Q?Dj4i5QmukgB9Svjy+u63SdyHELtsq8nPGCb0b6po4SBMeCTyUeF/R7jUTjI6?=
 =?us-ascii?Q?XUxltY4H+wCTjxnpS6Y9jCybQ3rSbVYrHtWEVBnPwXeJCHdHLZow7A3C6tkr?=
 =?us-ascii?Q?1gtPMsXoO3XWp+0bTp5DYXr7+1HK2yiGHK0XQt2cbtLL2HbNjlf5ECBL55eP?=
 =?us-ascii?Q?OATyu+1b3phap3NnNbFVu7Eizle/p1AJsn/Co29uMC7KSIcp9A/CqyI+uJTU?=
 =?us-ascii?Q?TkFjZvPTNk6EvZYgoWeb4GNsSXV0wi5mRA5+qHDwhitjTvmKZWAYI70uRzi2?=
 =?us-ascii?Q?NcA/rfWum1WeQAHVNAM4bOxqCjfdqerlnDBoT+GCscv3R5A8c2p5uIU/rIlZ?=
 =?us-ascii?Q?uAgBMkWjTO+4MBjVEcdto/+5t3KM3PnXkxqYN5g6oDMuRkEeNCRbsWRmzo2t?=
 =?us-ascii?Q?Zy5NfJ9HpAi1TVNTmCjnrG6WjN9CV37DqI8YXEH4glxo+0hKivvqQVuIYSXT?=
 =?us-ascii?Q?73PrBNJJ8OUUw5HDWVuNJ7c61ZEyvcWPT8nfWf1Sdb9yYIF9Euhs+QzBS99h?=
 =?us-ascii?Q?6PxG8fd5xXSOTf6ToEfBdah8wYYDuN8BHm1G8WBFB8YAvZYXgaFE09iOG9ou?=
 =?us-ascii?Q?lZ7WNk5Q3rLM0M/2V6LvmkesDAye+r46DETKlh8B+yekoGMjqxVuJ3lzWev1?=
 =?us-ascii?Q?zIBRvABLxKfFtQc4uu/VhOZtODcX1YmY6xWZGZSG4qUkkVuI7kU1BFU6tt3S?=
 =?us-ascii?Q?Gc12cABpCAckx1+R2KdM80j05ki3sHiRH8MfOjE2z7A9X16iwoy+tCOS6OaN?=
 =?us-ascii?Q?hE7bSUdVgERNXAGUTXZKVbZYjIx023lD5JLuOYWiMM43jHnOfNiTMLmS7Hrb?=
 =?us-ascii?Q?DFTjUrB/IkGQ3lxAq5DSGiRGkHWPG9s1JxGoy5nYHrMDOPbnisLU/O4eo9OE?=
 =?us-ascii?Q?FdsPWVjty4k+YcBx2o7AfHaqx5y0vX3zKo33y7QEcj5cKg47aedqQp2iIZ7V?=
 =?us-ascii?Q?9SVOQDdFTKm+OpwbRH1Yyy2PYZrcbV9ByrfQTFNkINVNWXCisV+V21QV+BPn?=
 =?us-ascii?Q?VUWu2rdWLQzKKs3i7ERymjfYQgagFp4EmK6xFhcvxYzEFCeo/Ax49ZCHHBcC?=
 =?us-ascii?Q?p+rXtvlKhGrYgxDrVeWB5EYBqB7qM2YMxGsF/YFLA+xxlxgOhd3j82mn0AbG?=
 =?us-ascii?Q?QmzB0Awafajbagdrt0E8MygYGT70O4O933qfAYo5oGWBnCWjP+G+Jpx3z97N?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 323b1021-3683-4a92-53f0-08de179f5dbe
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:30:37.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a8zFFSCLLX0H/ewqOWtY7+kA6y6+J+OVHeqwKC+G6T6ccYz1xKfkkzpYR0caESrIK2QDnnEqTNriEf98YewatN6adSZPNr83oG5oHwnxJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

On Mon, Oct 27, 2025 at 07:41:36PM +0100, Geert Uytterhoeven wrote:
> Prepare for the advent of a globally available common field_get() macro
> by undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

> --
> v5:
>   - New.
> ---
>  drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> index 69295a9ddf0ac92f..6186fafb4a7b0dab 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> +++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
> @@ -11,6 +11,7 @@
>   * pm_scnprint_table(), making it not compile time constant, so the compile
>   * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
>   */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
>  
>  #define PM_INFO_MAX_KEY_LEN	21
> -- 
> 2.43.0
> 

