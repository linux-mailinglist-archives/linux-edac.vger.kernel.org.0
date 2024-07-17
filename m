Return-Path: <linux-edac+bounces-1542-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA309341BA
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 19:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5071C21182
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A9182A40;
	Wed, 17 Jul 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfaT9YBO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C0181B9A;
	Wed, 17 Jul 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238925; cv=fail; b=akscywxA7imMMK6UnKjPYodUYjFz7G7NOohhed1vOUZ3ceyJwYuTDymwescK9/PxoPy8IzIybuPM0J/uQ8dQ8QT2nZV8Dfckkl9eYjDx35K3f26mWxT8r+iKe5AeCHTzwniS5iFqVbS9J9n5ksqmQTlqppF8YkxhFkTxFSVSMVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238925; c=relaxed/simple;
	bh=hLgttD2/KidnY1ej9TsVFIzBWVf/F6Mivc7jo7zXNIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRBRyby+HPYVwP0wM1TsWBmQxbIceyunC7JwFe0gjPIUfXMeCK5juwzXydcNbObul9/my+Zk9/q7otAyowJL91l0lpfoNtDJf3AVxFHgX4G9ENb65cddkHdJin2FbC7igSU8ETrwKUuuE9XIE0divP5T6RuPQd8xAF20dcEqBuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfaT9YBO; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyCpfWZR72nZsXjko99vHggPBT/5g9G9KPZwxuHGtwX5/DRc0+BjjYRCBc2MVLVT7DJkE6gUj3eUOHAE2/XBqAyZ+MNT0o3AKREP8XCdL04w487M7witb7E0jSKBqNpVxgjfYs/xWTlxlidezLGmpn4hiWsKnO6+YwfokFlwMHQ/x4dHvv8ouzWRV4l2lP4T0tawAYeKq+fuEq4sR6s5gzGA6Og3xREiXw5mSYVZemGG0pGuJVGRalkcvy+37eC3Z4xbFhAnvB1NNGkDtxs8Qw0c6HzDhhZhASf47Fyhd76F301LW0WmX+WJfnTIGgZJWfm7e80tM8iNGI8rKOf2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6sKoX4kZOEa7jFNpt1eDRl7Ft5huw0Ud4I0vw6qnXA=;
 b=RF8wDfMaVd1dyLKu8EkIO2aLiTxF7o07YxjBf2VvN7BS9A+sRHpexEJ9kice+Dp9tk+6v402xViSNtR45ubpg6qF1slobDJBtYYC6IqytZMvxe4xCpx6+wO6FksCoT5kJ2CbbNhMt8KNKL+iJTkxXcJytaS9Z1fQbb1scNB5a3hUwerh2/s5x7o5Irgzb5t6TnY/Kvp9F9TIgLVchE+4ScM3KrdmEoXJuq1tHBhkrb3X/QeRuu9OgPGmzeXPfrgaOhnx6BozCUm3ATDjgGuXuocwwiPpTs2s0dm9N+ON6xSyTJwIlB9ZWaaWytJwGGnL6egU0StGqBrnfOEGd8xrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6sKoX4kZOEa7jFNpt1eDRl7Ft5huw0Ud4I0vw6qnXA=;
 b=nfaT9YBOni+O6rXuCi1Upd02KvEjpl1Vl1N3O6MmxIT61TgrpMArilU3vhP4tavaaovfWzMekoG2+CJXPuHrPmWyiMsYsz44jIv+8V5YqBdsU8/3UhjNc1hm58EA95CQFdw6eLJlJCdUPPcCm0kN+JDexkqEBHpGCDhVRED3KfgKrKFImfB84RGMBoM2EVu58TclXoc1/WV4KR0c66VvT5h9tWHmRljTHwpr2XBVoaPq61nUAkNR8MlKvAWUllmq/+5cNKyzKKX7+wQMstxsfQOxpyhp2NilMClu/0INr9bu9wdyVAUuKuuQPB9T5L9AbMd5C0/6LEShjAoydbWoNA==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Wed, 17 Jul 2024 17:55:19 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892%4]) with mapi id 15.20.7784.015; Wed, 17 Jul 2024
 17:55:19 +0000
From: David Thompson <davthompson@nvidia.com>
To: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
CC: Shravan Ramani <shravankr@nvidia.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Topic: [PATCH v2] EDAC/bluefield: Use Arm SMC for EMI access on
 BlueField-2
Thread-Index: AQHawZcLvtIw5VYGyk2nr9pnxACEa7H7YbPg
Date: Wed, 17 Jul 2024 17:55:19 +0000
Message-ID:
 <DM6PR12MB553449C7E5BC89FFC7F11422C7A32@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20240618154819.28825-1-davthompson@nvidia.com>
In-Reply-To: <20240618154819.28825-1-davthompson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|DS7PR12MB5840:EE_
x-ms-office365-filtering-correlation-id: 3a44bbd4-18a3-456d-0ae6-08dca6899f7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Owqkl11Lcvgliky8OVaEpJ3one/W7b+bSi7FzFs7hiCo3nXnotvU+sYnUCen?=
 =?us-ascii?Q?gZ16AbYw8oGzKtHtn9v4kjEYHt6eJVZ+cEAALJk6r1/hbspP7SOHZlUPcF2R?=
 =?us-ascii?Q?Je0TDGLkWSjwH2k2qpRfet+JY9RpEJAkFLFv2CwogeGJ+5qj0ESiO6ARNFZe?=
 =?us-ascii?Q?N/6dqpq4LnR+XMMl+4PG782zBW9bhwI00frTBRPuXj2L/dDUWzuTbGxTbyCh?=
 =?us-ascii?Q?x/DFACV/+R/yNEXgcKuilg1SfpwtEb6EPODHIWUXOvoDm07fSePdSbyIlxxn?=
 =?us-ascii?Q?Ut6oAfHihe7dVdvxvHl5rSS5BwkU6+4FIhFCUwGAKSGGFnfh+KhD9lEx7t73?=
 =?us-ascii?Q?Llb+Xb5GkUuQPsKUEQ3v32zEZvriDR6OMv843Xq1SV/hYJo9h5qXROsEMMdG?=
 =?us-ascii?Q?ez+Kd3Ho4p+70/t1jQL+lijks1LhivDerGprtN/Jy2iU1A5Up5t4DeeaU6q0?=
 =?us-ascii?Q?XIwR7JDns9ak+A+W2vNEbNGGkz5eMF5gZVh13RukCZzyUYLoRx8PqHIaw0X8?=
 =?us-ascii?Q?NcqZU+OV2Il/6ztzcaSPk0nZpg64ANS36Vtboz/nc3W04Vjlht9EExG1g3B3?=
 =?us-ascii?Q?nwJVneZMzdU7nBafZ/AIaDwVoWrb71PzvDJnk9L3eGO6iZgM5XMG/3b8Txm2?=
 =?us-ascii?Q?r6XbDPuihuratCbTgjoF83TuPIyGnQXt2n8T/lSeyULes9PZ3VBrlm9mwSdM?=
 =?us-ascii?Q?6n42ooDk99h6/ADopBfgpn2C/vZ1+dds0iIfX97qpECShfZKOYyrZ25lRVLu?=
 =?us-ascii?Q?PlWVN9II1qXBRm1dmnfJdlPNyf8gGa6I1DUurT9PCFhZ61Tt9n9Th/mFbJ/p?=
 =?us-ascii?Q?RQwKUdk5Ul0nMjKOut/yYK5wzfZk9mWGanAMh6BL3+eeyP5s2qOLrwYbkUgi?=
 =?us-ascii?Q?I5Ng0yexFHeJ+J5TxY9hFO5Hu+GapeL94pkemaFBS4jXJvgkhx/9j29IJp2O?=
 =?us-ascii?Q?swR3n3psbvGoLFC+f65RUlhgQb9/5HTcCSpt0Q3jmDKtd8GQ/JVCZuS6n0oV?=
 =?us-ascii?Q?+4hgyL2DzGP2s/hoR1AzSTw2evzhqHvyvn4m3Tz6/bmlf68MCLv/w7/jYKUm?=
 =?us-ascii?Q?3hxJM4rvpfjC+tLB4Bf49Au2XtbH+mNJ1ndZERFLt5bgGoCW5ivD586+oIzn?=
 =?us-ascii?Q?eLYIXC6wQH43Gu1lBfs4DvNhmtz/JdUfG/AtshZhe0fAaviPJYcAfBbwxuV2?=
 =?us-ascii?Q?lzfOF3GtyIKD1RepavOzDlw2X96OSNEdj6S6wowp6j10ZQE6FVKGIg1DGJxN?=
 =?us-ascii?Q?IOvFDOElYl3EyX+1LFiEQ9xsxmB2HigVo6oOKqpv/0TIoL4E2cS94lvzkoDG?=
 =?us-ascii?Q?g17ATzmf+GwGArge3AhzbAnA7vaMp5k49/TahP5MVZ/esmro7Q/kVckXQOLf?=
 =?us-ascii?Q?Cca0HkiGukhPmBYdg5mImRDvmqEEeIc5xFMAfYLr3XQiH0SSTg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cagh39z2Ap5FcH452cD1+zI3JkLrm0xdquve+xrsAikIMilOkFim1PMGyk1Z?=
 =?us-ascii?Q?DOSwvjUoxdZVFvtW2L9h/86b8Ruy6EJXemGHF7+Y0jIsln4u2ABmWqEjeoX9?=
 =?us-ascii?Q?+ssndUcv4xQNnzH30TGqMWnPA9wCJelBmB1VxrA4im4ePFYdkVVjxE1LnR2b?=
 =?us-ascii?Q?T2GuBAWWwh8HjOCH/UUQP66sz2gT20+Svx7RWd30SLP9DQ6kEYUxbAOZElKo?=
 =?us-ascii?Q?bWep0qMZySgeiNXl3Eip0A/dc33yVep63c/1YZaPFZLaWaWCKOdPiLJq7exV?=
 =?us-ascii?Q?s8LrszNsaykB+Z9tfjrkQMnleCAGRKImB5LigeaDqclfvx2HbjulBjfb9h6Q?=
 =?us-ascii?Q?jtR2E7GGGr45vkOg5uf+gRHrplHG4ENHkJ92DWBCQuPIha9LPt7IzZyYpl5V?=
 =?us-ascii?Q?wmDPqH/qKqZ/81Ik/HTxVY86OknhLOA9szzR6VJinYlvME3lAYHSuPe6zARp?=
 =?us-ascii?Q?bl06tqqE5Kxu7QuHGMcNXq0k3pNuSx1lJ9LfXzTr2yiMVyDt5xZNymE3as1l?=
 =?us-ascii?Q?zDeTFJjKG+yz6Nkg4NFfflby2PCMl9fxqskGoBtZBEvEv9vyUa+3djID770F?=
 =?us-ascii?Q?f5FEbCk6IJYQMbUUPmQG8nEWtRF9SG9wXnqwNL//LKMngmE0t/jaBNcQr6kh?=
 =?us-ascii?Q?dmw23A3fBBrRnVRPxMKPThN/LTNH2j9e9tbUCYpCyZULy2PJ89XNJR/nSt5y?=
 =?us-ascii?Q?mBq5E+h4Kne4yQeGUDp7LMMcuAkwasqBh9RfIwKQbBM67xGUjTFX48+/zOwj?=
 =?us-ascii?Q?8crvoOzgBSX/j0qkysBMfSAWCYz2aqB4i+skaV3jDU1JuKi54iTaB2vCvYlD?=
 =?us-ascii?Q?gWj1vHIC/Eqdcytcjh/nVvYDaA/FRTG2iYV2ya4c2uHoVhi/8/Has5e/z5Cv?=
 =?us-ascii?Q?ct7vnuPumE7TFBUHWoZCav0baQB8QZ3DYRv25+crSF2VJs3WXCX/1xjbQ4uw?=
 =?us-ascii?Q?GppgkVyfQDRPr36PvcpQi2H3ogM3fLUzhor2IHs6Z5RkGDsHr4iWiNdpUJkh?=
 =?us-ascii?Q?vX3FNWDdGlXD3yGr4ZIBg3Ts6yqr034JRuh1Cj9eMAp1q0v7Q31+IBUHMLmk?=
 =?us-ascii?Q?IyGU04clPC8gklebh2/zintT2LGAWfJQKyrvrwH2sECz0Ub91hbqrtN7vKxu?=
 =?us-ascii?Q?LTr+R5L7xMEZSI3QMwGHwdxM2wOKDEFxMFTkgJTQ2TF+RdhiwpgDT6pGnsOP?=
 =?us-ascii?Q?TqaeToEpuuyp+/7/0ITFYCsjFy2btBU7G3lZdp/uCK7o5xUtUCiPGkQQD5Y8?=
 =?us-ascii?Q?4UmhKWEkcjA81Yst+ffPM+d1wAbydFyBJ+gq+LIl5+e1ueSQ7YHmGYzNQ+cl?=
 =?us-ascii?Q?15Kf+G2j2jBI3/CmV/0xYWmJlP5fgyU7dSUSDGbtgts8ESsPifePMtQ/cY4C?=
 =?us-ascii?Q?mJsBFSAr8df9ymXlrY2e7WxQGEeaT/CBaoaSDJxzCYs8ZQVBCI9pdrZIBseW?=
 =?us-ascii?Q?H11+Od081zhlf7LXvh5RUPgvyXWfgSwTQDUmW7N/hymZLO6vmPQU+q401qgt?=
 =?us-ascii?Q?75JN5qa2WAaIs1ztvJLfjNQOLkLRHMuIZ13QnjQ/Vp+ahHiHWCmpKx0lhoNt?=
 =?us-ascii?Q?pg23QGqRwCqS/mWJQvKV359d36mxIVUIZtZ3MKjX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a44bbd4-18a3-456d-0ae6-08dca6899f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 17:55:19.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBtFqQR+oE+c9GjOkpXjT71VXVrbLou3+48zPV0nrVlK4C2XX3hdLU1UAYAPcxzK2lldJJT7097w2Sc+vZv1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Tuesday, June 18, 2024 11:48 AM
> To: bp@alien8.de; tony.luck@intel.com; james.morse@arm.com;
> mchehab@kernel.org; rric@kernel.org
> Cc: Shravan Ramani <shravankr@nvidia.com>; linux-edac@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; David Thompson <davthompson@nvidia.com>
> Subject: [PATCH v2] EDAC/bluefield: Use Arm SMC for EMI access on BlueFie=
ld-2
>=20
> The BlueField EDAC driver supports the first generation BlueField-1 SoC, =
but not
> the second generation BlueField-2 SoC.  The BlueField-2 SoC is different =
in that
> only secure accesses are allowed to the External Memory Interface (EMI) r=
egister
> block. On BlueField-2, all read/write accesses from Linux to EMI register=
s are
> routed via Arm Secure Monitor Call (SMC) through Arm Trusted Firmware (AT=
F),
> which runs at EL3 privileged state.
>=20
> On BlueField-1, EMI registers are mapped and accessed directly. In order =
to
> support BlueField-2, the driver's read and write access methods must be
> extended with additional logic to include secure access to the EMI regist=
ers via
> SMCs.
>=20
> The driver's probe routine must check the ACPI table for presence of the
> "sec_reg_block" property and ensure the minimum required SMC service vers=
ion
> is present before enabling the BlueField-2 secure access methods.
> The "sec_reg_block" property is only present in BlueField-2 ACPI table, n=
ot the
> BlueField-1 ACPI table.
>=20
> Also, the bluefield_edac driver needs two coding style fixes: one fix add=
resses an
> issue raised by checkpatch, and the other fix provides consistency in dec=
laration
> of #defines.
>=20
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
> v1 -> v2
> a) removed #defines for SMC function IDs that are not used
> b) added "bluefield_edac_" prefix to "secure_readl/writel" functions
> c) added "bluefield_" prefix to "edac_readl/writel" functions
> d) changed logic to use "uN" typedefs instead of "uintN_t"
> e) added initialization of "priv->dev" in probe()
> f) added more details to commit message
>=20
> v0 -> v1
> Updated commit message
> ---
>  drivers/edac/bluefield_edac.c | 174 ++++++++++++++++++++++++++++++----
>  1 file changed, 155 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.=
c index
> 5b3164560648..4e0db1cbfbe7 100644
> --- a/drivers/edac/bluefield_edac.c
> +++ b/drivers/edac/bluefield_edac.c
> @@ -47,13 +47,22 @@
>  #define MLXBF_EDAC_MAX_DIMM_PER_MC	2
>  #define MLXBF_EDAC_ERROR_GRAIN		8
>=20
> +#define MLXBF_WRITE_REG_32		(0x82000009)
> +#define MLXBF_READ_REG_32		(0x8200000A)
> +#define MLXBF_SIP_SVC_VERSION		(0x8200ff03)
> +
> +#define MLXBF_SMCCC_ACCESS_VIOLATION	(-4)
> +
> +#define MLXBF_SVC_REQ_MAJOR		0
> +#define MLXBF_SVC_REQ_MINOR		3
> +
>  /*
> - * Request MLNX_SIP_GET_DIMM_INFO
> + * Request MLXBF_SIP_GET_DIMM_INFO
>   *
>   * Retrieve information about DIMM on a certain slot.
>   *
>   * Call register usage:
> - * a0: MLNX_SIP_GET_DIMM_INFO
> + * a0: MLXBF_SIP_GET_DIMM_INFO
>   * a1: (Memory controller index) << 16 | (Dimm index in memory controlle=
r)
>   * a2-7: not used.
>   *
> @@ -61,7 +70,7 @@
>   * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
>   * a1-3: not used.
>   */
> -#define MLNX_SIP_GET_DIMM_INFO		0x82000008
> +#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
>=20
>  /* Format for the SMC response about the memory information */  #define
> MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0) @@ -72,9 +81,12 @@
> #define MLXBF_DIMM_INFO__PACKAGE_X GENMASK_ULL(31, 24)
>=20
>  struct bluefield_edac_priv {
> +	struct device *dev;
>  	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
>  	void __iomem *emi_base;
>  	int dimm_per_mc;
> +	bool svc_sreg_support;
> +	u32 sreg_tbl_edac;
>  };
>=20
>  static u64 smc_call1(u64 smc_op, u64 smc_arg) @@ -86,6 +98,71 @@ static =
u64
> smc_call1(u64 smc_op, u64 smc_arg)
>  	return res.a0;
>  }
>=20
> +static int bluefield_edac_secure_readl(void __iomem *addr, u32 *result,
> +u32 sreg_tbl) {
> +	struct arm_smccc_res res;
> +	int status;
> +
> +	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
> +		      0, 0, 0, 0, 0, &res);
> +
> +	status =3D res.a0;
> +
> +	switch (status) {
> +	case SMCCC_RET_NOT_SUPPORTED:
> +	case MLXBF_SMCCC_ACCESS_VIOLATION:
> +		return -1;
> +	default:
> +		*result =3D (u32)res.a1;
> +		return 0;
> +	}
> +}
> +
> +static int bluefield_edac_secure_writel(void __iomem *addr, u32 data,
> +u32 sreg_tbl) {
> +	struct arm_smccc_res res;
> +	int status;
> +
> +	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
> +		      0, 0, 0, 0, &res);
> +
> +	status =3D res.a0;
> +
> +	switch (status) {
> +	case SMCCC_RET_NOT_SUPPORTED:
> +	case MLXBF_SMCCC_ACCESS_VIOLATION:
> +		return -1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int bluefield_edac_readl(void __iomem *addr, u32 *result,
> +				bool sreg_support, u32 sreg_tbl)
> +{
> +	int err =3D 0;
> +
> +	if (sreg_support)
> +		err =3D bluefield_edac_secure_readl(addr, result, sreg_tbl);
> +	else
> +		*result =3D readl(addr);
> +
> +	return err;
> +}
> +
> +static int bluefield_edac_writel(void __iomem *addr, u32 data,
> +				 bool sreg_support, u32 sreg_tbl)
> +{
> +	int err =3D 0;
> +
> +	if (sreg_support)
> +		err =3D bluefield_edac_secure_writel(addr, data, sreg_tbl);
> +	else
> +		writel(data, addr);
> +
> +	return err;
> +}
> +
>  /*
>   * Gather the ECC information from the External Memory Interface registe=
rs
>   * and report it to the edac handler.
> @@ -99,7 +176,7 @@ static void bluefield_gather_report_ecc(struct
> mem_ctl_info *mci,
>  	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
>  	enum hw_event_mc_err_type ecc_type;
>  	u64 ecc_dimm_addr;
> -	int ecc_dimm;
> +	int ecc_dimm, err;
>=20
>  	ecc_type =3D is_single_ecc ? HW_EVENT_ERR_CORRECTED :
>  				   HW_EVENT_ERR_UNCORRECTED;
> @@ -109,14 +186,22 @@ static void bluefield_gather_report_ecc(struct
> mem_ctl_info *mci,
>  	 * registers with information about the last ECC error occurrence.
>  	 */
>  	ecc_latch_select =3D MLXBF_ECC_LATCH_SEL__START;
> -	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
> +	err =3D bluefield_edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
> +				    ecc_latch_select, priv->svc_sreg_support,
> +				    priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "ECC latch select write failed.\n");
>=20
>  	/*
>  	 * Verify that the ECC reported info in the registers is of the
>  	 * same type as the one asked to report. If not, just report the
>  	 * error without the detailed information.
>  	 */
> -	dram_syndrom =3D readl(priv->emi_base + MLXBF_SYNDROM);
> +	err =3D bluefield_edac_readl(priv->emi_base + MLXBF_SYNDROM,
> &dram_syndrom,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "DRAM syndrom read failed.\n");
> +
>  	serr =3D FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
>  	derr =3D FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
>  	syndrom =3D FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom); @@ -
> 127,13 +212,24 @@ static void bluefield_gather_report_ecc(struct mem_ctl_=
info
> *mci,
>  		return;
>  	}
>=20
> -	dram_additional_info =3D readl(priv->emi_base + MLXBF_ADD_INFO);
> +	err =3D bluefield_edac_readl(priv->emi_base + MLXBF_ADD_INFO,
> &dram_additional_info,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "DRAM additional info read failed.\n");
> +
>  	err_prank =3D FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK,
> dram_additional_info);
>=20
>  	ecc_dimm =3D (err_prank >=3D 2 && priv->dimm_ranks[0] <=3D 2) ? 1 : 0;
>=20
> -	edea0 =3D readl(priv->emi_base + MLXBF_ERR_ADDR_0);
> -	edea1 =3D readl(priv->emi_base + MLXBF_ERR_ADDR_1);
> +	err =3D bluefield_edac_readl(priv->emi_base + MLXBF_ERR_ADDR_0,
> &edea0,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "Error addr 0 read failed.\n");
> +
> +	err =3D bluefield_edac_readl(priv->emi_base + MLXBF_ERR_ADDR_1,
> &edea1,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "Error addr 1 read failed.\n");
>=20
>  	ecc_dimm_addr =3D ((u64)edea1 << 32) | edea0;
>=20
> @@ -147,6 +243,7 @@ static void bluefield_edac_check(struct mem_ctl_info
> *mci)  {
>  	struct bluefield_edac_priv *priv =3D mci->pvt_info;
>  	u32 ecc_count, single_error_count, double_error_count, ecc_error =3D 0;
> +	int err;
>=20
>  	/*
>  	 * The memory controller might not be initialized by the firmware @@ -
> 155,7 +252,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mc=
i)
>  	if (mci->edac_cap =3D=3D EDAC_FLAG_NONE)
>  		return;
>=20
> -	ecc_count =3D readl(priv->emi_base + MLXBF_ECC_CNT);
> +	err =3D bluefield_edac_readl(priv->emi_base + MLXBF_ECC_CNT,
> &ecc_count,
> +				   priv->svc_sreg_support, priv->sreg_tbl_edac);
> +	if (err)
> +		dev_err(priv->dev, "ECC count read failed.\n");
> +
>  	single_error_count =3D FIELD_GET(MLXBF_ECC_CNT__SERR_CNT,
> ecc_count);
>  	double_error_count =3D FIELD_GET(MLXBF_ECC_CNT__DERR_CNT,
> ecc_count);
>=20
> @@ -172,8 +273,12 @@ static void bluefield_edac_check(struct mem_ctl_info
> *mci)
>  	}
>=20
>  	/* Write to clear reported errors. */
> -	if (ecc_count)
> -		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
> +	if (ecc_count) {
> +		err =3D bluefield_edac_writel(priv->emi_base + MLXBF_ECC_ERR,
> ecc_error,
> +					    priv->svc_sreg_support, priv-
> >sreg_tbl_edac);
> +		if (err)
> +			dev_err(priv->dev, "ECC Error write failed.\n");
> +	}
>  }
>=20
>  /* Initialize the DIMMs information for the given memory controller. */ =
@@ -
> 189,7 +294,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info
> *mci)
>  		dimm =3D mci->dimms[i];
>=20
>  		smc_arg =3D mem_ctrl_idx << 16 | i;
> -		smc_info =3D smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
> +		smc_info =3D smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
>=20
>  		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
>  			dimm->mtype =3D MEM_EMPTY;
> @@ -244,6 +349,7 @@ static int bluefield_edac_mc_probe(struct
> platform_device *pdev)
>  	struct bluefield_edac_priv *priv;
>  	struct device *dev =3D &pdev->dev;
>  	struct edac_mc_layer layers[1];
> +	struct arm_smccc_res res;
>  	struct mem_ctl_info *mci;
>  	struct resource *emi_res;
>  	unsigned int mc_idx, dimm_count;
> @@ -279,13 +385,44 @@ static int bluefield_edac_mc_probe(struct
> platform_device *pdev)
>  		return -ENOMEM;
>=20
>  	priv =3D mci->pvt_info;
> +	priv->dev =3D dev;
> +
> +	/*
> +	 * The "sec_reg_block" property in the ACPI table determines the
> method
> +	 * the driver uses to access the EMI registers:
> +	 * a) property is not present - directly access registers via readl/wri=
tel
> +	 * b) property is present - indirectly access registers via SMC calls
> +	 *    (assuming required Silicon Provider service version found)
> +	 */
> +	if (device_property_read_u32(dev,
> +				     "sec_reg_block", &priv->sreg_tbl_edac)) {
> +		priv->svc_sreg_support =3D false;
> +	} else {
> +		/*
> +		 * Check for minimum required Arm Silicon Provider (SiP) service
> +		 * version, ensuring support of required SMC function IDs.
> +		 */
> +		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0,
> &res);
> +		if (res.a0 =3D=3D MLXBF_SVC_REQ_MAJOR &&
> +		    res.a1 >=3D MLXBF_SVC_REQ_MINOR) {
> +			priv->svc_sreg_support =3D true;
> +		} else {
> +			dev_err(dev, "Required SMCs are not supported.\n");
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +	}
>=20
>  	priv->dimm_per_mc =3D dimm_count;
> -	priv->emi_base =3D devm_ioremap_resource(dev, emi_res);
> -	if (IS_ERR(priv->emi_base)) {
> -		dev_err(dev, "failed to map EMI IO resource\n");
> -		ret =3D PTR_ERR(priv->emi_base);
> -		goto err;
> +	if (!priv->svc_sreg_support) {
> +		priv->emi_base =3D devm_ioremap_resource(dev, emi_res);
> +		if (IS_ERR(priv->emi_base)) {
> +			dev_err(dev, "failed to map EMI IO resource\n");
> +			ret =3D PTR_ERR(priv->emi_base);
> +			goto err;
> +		}
> +	} else {
> +		priv->emi_base =3D (void __iomem *)emi_res->start;
>  	}
>=20
>  	mci->pdev =3D dev;
> @@ -320,7 +457,6 @@ static int bluefield_edac_mc_probe(struct
> platform_device *pdev)
>  	edac_mc_free(mci);
>=20
>  	return ret;
> -
>  }
>=20
>  static void bluefield_edac_mc_remove(struct platform_device *pdev)
> --
> 2.30.1

Hello, I'm reaching out to check in on the status of this patch. =20

Please let me know if you have any questions, concerns with
the patch, or have changes you would like me to make.

Thank you for your time.

Regards, Dave


