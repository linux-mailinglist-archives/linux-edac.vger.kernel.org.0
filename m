Return-Path: <linux-edac+bounces-3191-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBABA42096
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D9D7A7A33
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76587248894;
	Mon, 24 Feb 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPTf+Bza"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26A1B041E;
	Mon, 24 Feb 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403713; cv=fail; b=Od9VtzL+yqMnSOFMBbnGYzub82KOMUFTzS5HLXAQkYgKpgq9BVOPF/XxF5cl3bIEr87e+6YPTz9dX9vmMTTD7LtnrmqGwdL3+gp/a1X4RUf0A01d0V5hHUTNevyErOMoi1s3hl8XcOcsf2bhJuSf05zgIVGPvRcDA8P0OrduOTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403713; c=relaxed/simple;
	bh=H2k9111kKJ8r4u28JyRRlxhUdQOpQjVOZCG5IobUEFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/i+4UjjOq/G+DZkJU1ogCjwsDORmpJFJnQkrMKmTLL+JfYEpNVlBy0qubvJVwAk1XrO8nHTAPPAu0XMdn1b42PnGZkgFNL/iSSp4kE5LvrMPnqqIkkeEzlLahEwrfR7JwTpizjfxVvUOeEFY6iPhcJgImjCCmpNnYN1yImvEZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPTf+Bza; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740403712; x=1771939712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H2k9111kKJ8r4u28JyRRlxhUdQOpQjVOZCG5IobUEFc=;
  b=kPTf+BzaWiIhCyyKOW333zjtEWWco3x+yZboc8gIq9qID8X6sRi/8GZZ
   V3htk+cpZdmmdc9SHZ3Oq4YoXlMm5pKV11PChGG0hLntNa/65H/xKgcyC
   XHaZtPtAhjEgf0bmSB/GFlaWCOfKVMj4v1y/OjzUcl7DXQRkHf720dKDd
   N28vhUyv9BTsXpkGqQGb8ZJCVjIqa42nIRF0dX0esv7NKTwUgHRNzXzci
   nhcBqH5uW89SiwPTvdF6nqao8J1ucYu5wm0KXI5w75At49u5CWMzoeVHs
   n8bkkKTku8cJ/584FJM+ftgbsaNxqsnDIr0djW+bfTYuR7JWIWF6Xfxej
   Q==;
X-CSE-ConnectionGUID: p8BwranwSd+PB/XzOPWoQw==
X-CSE-MsgGUID: 2c6ZQDtTQ8ezgQ2xYL6Uqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45064872"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45064872"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:28:31 -0800
X-CSE-ConnectionGUID: vr2dzZ7XTdicvqTe5QdPJw==
X-CSE-MsgGUID: UOOGk3nqTO+cVwTQYwhp7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121154361"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 05:28:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 05:28:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 05:28:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 05:28:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsO4VWgY+vix8Ktqpd44o2U8COL0J0hjgp3m+tCFK3zrB6B/bYZjSvXFkhoQmgVshofZG4oDQXzdictFH/RK5uWaAY+GUAG/aKvsWS2wi3fFT+u+S8IUOdIJ7VN32oYDJTKZdTVxjeqOYfLjj8SDiNmJWwxJIETsK6reHMj1xvutspSzxF5XTc3EiX/G9LXX4vVE2/VVNe5m5c/YbOn/bvDN8iF0W4v9svv/GkPR74Om9Q7N8zNlpJtIg5NxFoxDJbgAG8Tek5ujp7nnzZEKdqI6b3FzjstoTXBpeFwBVCAnHTZUr4Oa7vqZglSrCU/HhVTUq9yj5tdizJs3DWZ7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=117/949cz7D67LBlu3aHDDjxJEtsmFgGsp61Lh8eYgg=;
 b=iqSHvXxl/mjXBqD777gHiXLWqjKxcW8OL9wRaHpMYnY61+RjLrU+M3dqFew3qQO5Y5214y0picQ11n/Yy3ecXcfL2/B6SxksXb+/Nyj4UVoXy2/n9/n8M5kPliQOyfKmdCsnpttOOgH/EdwfKS3SwwrED4KaDGOfyqIi6Nh1Owoa1nbgxMSERt7IG3HEUx7mVv2aW+SlUSWnwZVdWWWKkK122LXK35vH7BNGV7iPGfc6mmLjHASaafFDqMGN7dWVX0QfJRc/r+GQkp96T6gyuNH4TRqhxK/yIXG6n2iFivpRahOCRTPHJz2ETalAZD/W4DLCm6lkQwKP8d9up6EYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 13:28:23 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:28:23 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Topic: [PATCH v2 07/16] x86/mce: Define BSP-only init
Thread-Index: AQHbfjlT9nBBe5Yi8UGLWXfjZPPcjrNMZ98AgAJptYCAAJ+JsIAA2/cAgAY1FTA=
Date: Mon, 24 Feb 2025 13:28:23 +0000
Message-ID: <CY8PR11MB71342BEF686D52AA3ED52B0789C02@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-7-3636547fe05f@amd.com>
 <CY8PR11MB71348FE4A5684E941992B5CA89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219155745.GB337534@yaz-khff2.amd.com>
 <CY8PR11MB7134DA72B48006B403A6516D89C42@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250220143602.GB589698@yaz-khff2.amd.com>
In-Reply-To: <20250220143602.GB589698@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7321:EE_
x-ms-office365-filtering-correlation-id: b2b9fee0-5f1b-478f-90cf-08dd54d71ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lHrVR7ysX3pkqycutQV/yq88klLB3uaF4/drDlfeLxNvFB5NJsxqCLqZ7UCl?=
 =?us-ascii?Q?OJMcTAWmAGV+Q5vHlaoMJeT1WSRdyYvmbi+Zpv2v1r+HIrDOOV+2xU4coAZ6?=
 =?us-ascii?Q?yZmys7RNwY2iqbmQxT/zqFEXgNm6hgc059NY+wavuCYcCUlC/ElQDfgWInHy?=
 =?us-ascii?Q?g2qnQKUDmXQIvIpWtcXFMKdK+FGWTVM1QuY2a785qKQm3RewvfOhfYx4Ff7t?=
 =?us-ascii?Q?W69emMLHu6KDeG8kqHSopONzVxq072Yd91I5dkWwqve72fCL2l0Ej62Lx02H?=
 =?us-ascii?Q?wzexa4euaRDSy1S6mOiw2lpYjqMldwaNGhb1BO97Lo7pB2J2c7mildm8MkaR?=
 =?us-ascii?Q?kkhrEuzYKkyQDrOfHA3fmR4MGcH82EiZ/F9h1EWdzihpCIIDLlgeuHVQ2NYG?=
 =?us-ascii?Q?Jn1hghV6Q7fFYkmmpbO/ajGuErbbaBYyA9K+DMnCU0DI3vEVLbHV50Lr/Kys?=
 =?us-ascii?Q?XCT08TFp3j5YWxaC5D/6ppdHHv8Jyn1IyZLnbQF7R/hlYJak2v/n2Xb5WuUO?=
 =?us-ascii?Q?10sBY/UmSbCxeZf9fgi6ytHhovoG9XE/seNJU3/PkX3/vbO6NK7leTf35gTk?=
 =?us-ascii?Q?U8vkC1q7wPS1QJiMeY+T8hyHLPYquA35dTO1vOG9m7N+67U8pUk3RnfG4ewh?=
 =?us-ascii?Q?cJC9d6C3USzlM7A0pEThu06ISXNAS89vZtzhe3Umv6pRbHwspRw/zduVHwPD?=
 =?us-ascii?Q?aOrhzeA9FyCpRbbFUtCKKrZKOW3cM+KQouxr1k0pP//dMVSiX3D+GvQemLDc?=
 =?us-ascii?Q?oxc/51Hc6LL6GWCgTKyfB/fTzbdUxvYk4hANugR4F87uRC5HWjG7tUC47e+N?=
 =?us-ascii?Q?LsyMuoOUcbv5uLUwRCJzWsahlhAoUEEcsdi5vjsV4UUB8/UptdAEDHSITIC8?=
 =?us-ascii?Q?0X7fgEbFCbIaMv6brHSAKV/rRnRUjfykOdTosnGsO05RkVtHDiQA5NnT5Npy?=
 =?us-ascii?Q?gj9L/x5pBkP203M63XTyo13vrvKGoEp2V9iHPJO/fpawue7FftFtmAilwGB0?=
 =?us-ascii?Q?oPVlbTbji+QP3Kw3IrsuhbI4ZULDxut5H0QreuZiZ9ZF3V4GvzOqn7bEPXDN?=
 =?us-ascii?Q?bhGccogiF7Vobc3hUDXUflmoShko6r+jaFkdeJ8EHkOWHXAMgXbnh/9nHX5g?=
 =?us-ascii?Q?eIdf3osaaew7kKDNEmGv5zQz7/pzxT5yMBMDnpZN/ukGZ+hCD66MYfzWaToI?=
 =?us-ascii?Q?uV1noLbp6wuVta6gJ2MQpVSjBpiBNRtA6EhVSoT63Bte5TkSwzf/VGf1OTBU?=
 =?us-ascii?Q?ePSG29PUbOfc/CF27pogRiRyo9v65PA1VX2qgx2792QxED0aSqcQvmu2UktL?=
 =?us-ascii?Q?yiBmnFH+2DCwlrM33CrL3mgfRphur0pmSvXV6Ae2FK99FQL5kNXjBcRN++t9?=
 =?us-ascii?Q?VgaCZ7slparZPuFCaMEKofoe2witW1nBTzYhR01dc7A6BZLlmEd2RDZuDYJ9?=
 =?us-ascii?Q?XPpXRTcdDrQJ1SZ7DsEf1I0jiHUsgTY7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqm6Emq7nKwUlPUPkYwZ0OsUrHkqq7btzT9uaINaJ8ePJCtrq7JTsw2Tv96f?=
 =?us-ascii?Q?8N7RFCGZAe5LeIp4kzD++dexn/OZkEm4dTNbo4hpqKim45cMQrH2HVBNtVTb?=
 =?us-ascii?Q?BGcCE+6PKMDObpRYeTF7DHgEyVEUdw99yYuc05RPlMnN1y+/nQWb5+wIUfi2?=
 =?us-ascii?Q?mXnQ5PZzgL3NCoxSVKUEZX5HejaW12ZP2kNydWlCHa54yJL4ne49U0gWQ121?=
 =?us-ascii?Q?zQ7GSj9lePengXAAMZjLKnLUTuciBBRFHSVYelBfN2d93xAarIQDHjuD4eZs?=
 =?us-ascii?Q?X5VN8VzByw4soDhEwLWk7Pd9TH1c/WwR5Qv0GTWrAtYVmCq/VzoiPapGtU9C?=
 =?us-ascii?Q?EuzAn0z6lOWJBsJOwQJUFmgtiuZmzxFlJCxW59/XH+IGnTD5zS4moUX+nvcr?=
 =?us-ascii?Q?Yt7cI7qd/DwMQQPzVglZNCYpUylRT1+RCUsRgZpYMwIupxzvm3ALbV6xfYAL?=
 =?us-ascii?Q?+hQC7uX64+7Ml8PSaa9gltRK7iLHqTydfjDKgQs5YWFLJZR/K9Av0aEUVzQ8?=
 =?us-ascii?Q?kvuKZiJI+9h6GPcq1n9aUksYFP2gbS0Wcn7kwP7Wq6BRdUW2BSg7WJg/BWU3?=
 =?us-ascii?Q?B00DVhZYtv23SZ1EH96m4MGgCPk5BgYNuaavUWBqmVWcWyhBYTEwlGA90Nt9?=
 =?us-ascii?Q?fVAJW9aZ+0/gVW5SZrzWnF8mD1YmaJKZRWmuexsgjoPeNttyfkFWUYHtZZi7?=
 =?us-ascii?Q?bU4/rB2Eyan2ZvQHSswN9h0NoYc4fM7Q7nF1E8cbZ7zvMX1M//1lw2E+/Uxt?=
 =?us-ascii?Q?orvqHZjOnu6mRvqLzK73m2ObpV1uuqsEWHwdjGnvvEyIwXyKK9MWuvdAtvhL?=
 =?us-ascii?Q?E0ptHeZQcqs5pwUgI9Jlaygae3THWNHgEUd9YyukQS2ye+D7FqB8DiSd7Fgj?=
 =?us-ascii?Q?NwgIn2IZZnz8dmc9jM8IOqqxVQCuVFY8kquTAQGVuox+xiaYMmZY4gbIZHc3?=
 =?us-ascii?Q?ok9keHw61v67AQprKZtbU/EO5epxVKbBJBawTj8wDAalbzyh8fub/z8FCIf9?=
 =?us-ascii?Q?9agvgEL6Bd2ZsxNid6JhD55QBAeWfbWQ3rEaPTujNd7TSZ1okHdwhdQCDZ2i?=
 =?us-ascii?Q?cdnu8R3fEYLJuvBboGTdiUK8BpGLJVXAdUqunoaNNHWrBoPynNdGbf45VGFA?=
 =?us-ascii?Q?ex9ogKIx1yO/RCGFaSJdx4CkoBUiN5dO97T+Bl/8aLcXq96LI3sR1Aox6cVx?=
 =?us-ascii?Q?KlexmzkVTq3L43Ie1fNvasq2AyrEWeaRW3TrU8syCyaFUf7iUJAcufWiPxI4?=
 =?us-ascii?Q?HQZYtne+aRnMi3BRhJscMsUFvNUgirDzO6v9dV0EGc4kX2smlK5cxHc9Npsy?=
 =?us-ascii?Q?sffqrQYjjW/0LzCUrKPcOP5d3X9E/aVQ6fKLNJhGqfA3wgkKkmZJLofb/4In?=
 =?us-ascii?Q?NTRqaz8h8dMt4yin0/QQw7hD0Vk32/vs0MRrovz4qIzx206vWy5QZqTr/Jdy?=
 =?us-ascii?Q?HcNNTVOZ2kJg+fil85nu8Uk9mrhmNd73QfbNAP9iWGancgi+O9RMPa7Hri0j?=
 =?us-ascii?Q?BoHBqi3JwzYuH0V+ivVnZwtjFnIFaX2/9F74OghoLME+ZYYnaNdxkm/V4ARc?=
 =?us-ascii?Q?ZvOxWWsg6sEimkjLfrN7DVxZmMJFw/1Zb3H4FMf1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b9fee0-5f1b-478f-90cf-08dd54d71ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:28:23.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fltnIvIGl+iR3+xIVNYwpVzozjBFUFFNn9bHnl008yXiVaYxZ2FUgWnNuw+HpVMqPm8gw+3Tyw1OstYd5Xfr0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]=20
> It's okay if Intel CPUs run this code, because they don't support these
> features. The feature flags are generally derived from CPUID bits, and
> x86 vendors do try to make sure they are unique and not
> overloaded/redefined between vendors.
>
> The same is true in reverse. It's okay if AMD CPUs run code to check for =
Intel-
> specific features. The feature checks will be false, and feature-specific=
 code
> will not be used.

Thanks for addressing my concerns.=20
This patch looks good to me.

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

