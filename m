Return-Path: <linux-edac+bounces-5346-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39FC36AF5
	for <lists+linux-edac@lfdr.de>; Wed, 05 Nov 2025 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9833A660159
	for <lists+linux-edac@lfdr.de>; Wed,  5 Nov 2025 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08261334C3D;
	Wed,  5 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGTGQ7Ca"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746A333448;
	Wed,  5 Nov 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358802; cv=fail; b=eNAbjuFbTgweduZ+2wvCaZv0wxykmNmztz5YCiV7SqmbQRrHsZkQXh5O6MGWJl+WpS8wiFZn4T+1MViJtoy0QfhclteCuEqg5XHyD0rpmhiAT6U0U+VVxdqSy+lI5xLDYMiGi6+2UgqQsntCKRRGLPeh6syLOD3Q9mcOkqxfqVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358802; c=relaxed/simple;
	bh=/DyLCqn+hJms9BRO/YV5PsNmEeUkZeVSh0jQ/cW56q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hgE+793sF4cx61Ck2rW3hPit76ePrHfZGNvRS2t/cVwd8x4NemCs/PzfNCVTIjO2+48YfV/khiGEfPByA/T9XJoilqjOsbdAlV8oRo1vXHHv9svm15xuXL+V8AElU656cC+UvdWnXKLpcHorZYyim3wz3EmCOmauKiVkINh1Lu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGTGQ7Ca; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762358802; x=1793894802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/DyLCqn+hJms9BRO/YV5PsNmEeUkZeVSh0jQ/cW56q4=;
  b=GGTGQ7CaKRvbWCoasaSfwown89mP88+utxuwKPoGmfVt3IeIZRD51RVM
   ML/JV7ihXUbUP1MHHBVykqZpfQNyS2DL27o/TDzruqQot/ftaRIMMH4I9
   nFcBi2pCcWJoLGHl6/LRXcHaLwSd1uMusVqrc1PauKkBhY7ntTWvIGbbE
   Is9AAzDpxr4pzclSzZlqMradJeql+zHuGFxM1ItJKp4g61eA2spIIG6vC
   vl0In9pNxaCI1ysA1oRoaAYNPFcoTPIntLxhmfiMQIc5nUjW2D0QcYGwd
   0ZoQYM8bEVZqtBHvlw9A/tgRiA+6UE5jpkGzg2bOzJtPhgwoVMsplK3fS
   g==;
X-CSE-ConnectionGUID: HlXZc9LhSXqoVXFS1Hjf2w==
X-CSE-MsgGUID: WY0aUojmR5SxcFPYM9kCmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64515774"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64515774"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:06:41 -0800
X-CSE-ConnectionGUID: jKN5W1ltTTiONRrU2vA6+A==
X-CSE-MsgGUID: NYneLZeUQdmyszjMOq7YlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="224738729"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:06:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 08:06:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 08:06:40 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 08:06:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLv9pHVETBzfchufzjDquhBYGXnNkN5Neuyk7wji/uMp6tBwZBbj7ZCol7XRkTRbxw1+WkRYse8yIGPnTaed9L/4hua+lrbWlixF4YF/LdOHCieYhjzYQjv+BfaBqbSMGQ8iqdbDkwZ3iENAwcQ7+gimuY77JlYjI+g3/k1AbK0lzWj18NeO0FwjifdiQ5+DWjQI1UUY6HPMhy/EkVblB7otJ2Uc8He9UQntJvpTpf1nymPFw65eIL0e1dJbJrw09pXj/+NFbBSfDmDoJfV3OXEJE60PiyPixuEpCER79xVrEKeysKiN1mL5OMj57BDwuBKvrPffSHlR49O+sklpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DyLCqn+hJms9BRO/YV5PsNmEeUkZeVSh0jQ/cW56q4=;
 b=W48NG4cU60u5gSddXOohU4OD0Egck76EYTpisXYqdhyRkIYamu6hhV4U0XB8bfa8ngovz78ihvGXg+ROszYhO+LQfKxACD91Lp/R6QSB69+Mx3v0jUzDGIWuWAutmktxhHya2S9C7CQBYBbXv1ryE8TQ0jw+SMD9zh4+7GfFY/xb2Rg1K1quEWekx6u+muQnr5f2a7ODDQ95kKHUDF8Rw+7u5zCRPfveMuaysxnEmS30MYYK8/EwrKpQ+7zXcmCDNufgjJxjwmDENVtfKnzx/4bSManBwPWn5/zf/8Klu43vOWaB06lYbNrDO/RG+0CCdX/gxl8hwyHa+KcRU/RCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA4PR11MB9324.namprd11.prod.outlook.com (2603:10b6:208:569::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:06:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 16:06:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Ma Ke <make24@iscas.ac.cn>,
	"jbaron@akamai.com" <jbaron@akamai.com>, "bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v2] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Topic: [PATCH v2] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Thread-Index: AQHcTfsKcR8TEkZT5UuEECXUOM0SL7TjazUAgADU45A=
Date: Wed, 5 Nov 2025 16:06:36 +0000
Message-ID: <SJ1PR11MB6083FC73C0F44F07632D5814FCC5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251105022146.22105-1-make24@iscas.ac.cn>
 <CY8PR11MB7134DA6C1CFEBBD903D9F30D89C5A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7134DA6C1CFEBBD903D9F30D89C5A@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA4PR11MB9324:EE_
x-ms-office365-filtering-correlation-id: 72260259-1c33-46ce-0f85-08de1c854c4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?XhvW/DPNAD2VN+G/jhjvlSNFmceW/9o0GJSINtK5ZDthOo5Vi3ziyCdW3qBD?=
 =?us-ascii?Q?G/R7nEDFY6lfFVZVvP+zBkZ2cy1c706qCa0/NHOoSJASb2uFCI58Hs2mhOia?=
 =?us-ascii?Q?YLQZUaKaxc9rquiSib+mMv+8DGH5wypjqer6+lLC0Pv3fvd1h24Jc+D3chrO?=
 =?us-ascii?Q?FR7jSxJAcM6+GPbVydWl+sxwRW9ORTFrf+/njBwpogZ7kU/GVE+WZxvK9xof?=
 =?us-ascii?Q?4H+/dmpKEalmr5QaU8h/OLplT5mLl2gh7RswBzz1cdHPUPke5Um3KJbdMHUV?=
 =?us-ascii?Q?ks47qQhIbtQqX/k1k9lcqbIEZmTsRcX08IeRHpavzWOAA4TuqNfZLjSpQoSo?=
 =?us-ascii?Q?OYY1ysZTa02j6ZQ3nZTvKxZTu1hl6Z8nm5J6gdK74nVV1mqMJPVC76IhaCIN?=
 =?us-ascii?Q?lDpoIv+Get/UQ4oDgPUNEMqXdPm6eW1sOD8yTlNeMu8e9X0RMRcWs0RkLwvh?=
 =?us-ascii?Q?HOprU7J80MDIkxf8MeGNOacK4LNzN+k0ZQ1/rk46IwWiazLEgZo5HAnWkuBR?=
 =?us-ascii?Q?gYK9vYd4RuwFYHdYR68wEKYm45V/U2088S0W0ucx0DZMhMKP8T7KQaiewXuC?=
 =?us-ascii?Q?u3KPPMsE+W8JI0Q3cytLOZo2/hrxtl4jUaOYMx5NTMjl0FIOwWNqMpDxxbLv?=
 =?us-ascii?Q?XF2K67PoYJFVxTwDhBfcbuDynw8m0TQI8GOqC1IQHJQNmZb764Gyo6xGzNn7?=
 =?us-ascii?Q?H2zpHXa00hL53lDtj7GFLywrfqDXlFRVAwtG+S+/2ZTwkxTVXA9wjbLNTmnH?=
 =?us-ascii?Q?Wh1c6exvZ1mJ8PZ2Zdup8cY5ZmGo4o5qOQTMwWby4YF2j89+pMCALhYGPHgH?=
 =?us-ascii?Q?qGITMb6U0wTdWLbYWXgm6YIb/9nHthWVSYMWhVptDa64C+5RUI4V+EHJJcNk?=
 =?us-ascii?Q?aLuNMMRyAIE6cEMvM405yNo6q89hW4/bPQweOaxpanKouHZoi8t2U/9qGi/K?=
 =?us-ascii?Q?GSTz9YSAu4dDcpFYd/N4xUGbyDAZo22B268LZUFc6jItsHwzk4UPAArHGPDH?=
 =?us-ascii?Q?94zHJ2x7+FQHwbseDtl13eCBbca0i2Eh4ONoGL/+8KVDicuowe64bSs7xi8z?=
 =?us-ascii?Q?lOf616MCvwNEhBmOPb0cOlcXDnuy+xH8p5MKYWu3M+BVneVzazb7zjstj93B?=
 =?us-ascii?Q?IY01hyHZRocfkKTPFN436a1ImG7Ukk23ZXlfLpurVd8Un9J8pUKd//XdBJVF?=
 =?us-ascii?Q?XSeqA6KM8w76/TMKYX0CeGz1h1hE5LK7fuPC6a8hckViMwepdLyV0kG2j97V?=
 =?us-ascii?Q?I2vsqhH2DHY0T67Ig1mi1Su1cOjh7q+4OQL2XAdygVUwGKS+bkh5Nv/Oblg4?=
 =?us-ascii?Q?PUv/baDFsQUvVxAfvR9Mmrr/HT5fxw6G2LEiX95fNM3KduvW9cbCoVzSq5uN?=
 =?us-ascii?Q?kS324gM6ZoHBP3lJngL0g5nb+3ehQ2oA3lXJkWKWLf4qdafTh6HY/59Focq+?=
 =?us-ascii?Q?Gqkvu2ZZdtaLu7OJYHag1808/YzBxhixNuWuf0HlPzgKktOVjkL/jn7qhH1B?=
 =?us-ascii?Q?+hO2ebhVjcX8azrNNwJkuj74YmAUnSUYFbCL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lfoOtvw0HI2/RSqoH1nQ3Vs03GUW9nMFIcrA1L2ReC9KzfKcQkn1s7MSUOXJ?=
 =?us-ascii?Q?/6TF3/aC5XppDau8OrznjGrXtVzb72hapNPaNiOSNASYya+cmV8afeBYSMxX?=
 =?us-ascii?Q?lIKlFUnJVMrAqjNfVpZhg99Bqku22Lfuww6wUxzut0Nto4lgdTLA7ELPoK4g?=
 =?us-ascii?Q?+7JmxPJhS6HVOEAW2o8AFAImR/YKRpOnMcYZA9H7z1ftwEb+RSNo6yVtVxVG?=
 =?us-ascii?Q?2ls5Q0lm5Hy1f1teI2Z4AVA2be9iz4ZByFcU+y8Hdjn65zfiYAoAyFXkysu9?=
 =?us-ascii?Q?ams/ntc7QCxr15M8Wt+kSJTESOmD23IE5WZ1VqYT9EpYaIrr/YxUn86d7zK+?=
 =?us-ascii?Q?KhyB4loUJxkrdkyEICu82IHD58TwZDj4MIEBNDOYew3x5VeLv7wSgH2AW/fj?=
 =?us-ascii?Q?ygKXzVRSqcJpQBdNUKP2OsiWSVPKezh/Ajl20XAWv/s0C38riVlSHAgjiDS8?=
 =?us-ascii?Q?Va5mS1GWbuyEIpCG0ATWhXlW9EgpGKxNoa0qmQMrzEhNSSt9P+PE1bszur4w?=
 =?us-ascii?Q?viGJujOTfMDX43N2AVZbuWxmU6ZPrJrK94cXHZTluuypcMHjHV8tCdSKVgaK?=
 =?us-ascii?Q?SDWgXq+dmWSVM+J0sPiOuNoPAk7V69P5JFlC1M3pTVkYC/vew6koaz8JjbzK?=
 =?us-ascii?Q?fF48Tb/wzoROqeu20+fKQm5b9QmuG1cw3rdxa8EkFDpXqd+KRh5CHF3gBIDF?=
 =?us-ascii?Q?1eGm5fPz+hJ/lRWyj8cjovE0pvgJoGFl2x6G5fo46GRnbUKmIXs8hWOPGSEr?=
 =?us-ascii?Q?QVnuEZnIw+ZeYvKMZdyx6Og7TVAMANY5qxoBRKRNodmp+ooIFip2sIGHyT6k?=
 =?us-ascii?Q?NxyUsZEq3LkuvjUXovjSq1Y55amfjgLBvPt0dnzEOB/H7fXebb9B9JBtGNlQ?=
 =?us-ascii?Q?HAKcJn4dpCHhLgZF7j/nrbU2uoJ09t98fYIklwbCo/ytjq0n/+C9w7Iy2VdT?=
 =?us-ascii?Q?3hyY+uOg5iOS2QN/zvLgF3fmemV3VJ6zTWrWajGzm86DyD5Gid23WFzRqk9t?=
 =?us-ascii?Q?ID8dHAybxsbknb//2uzmcEhz3jB6BoL8fcRIHuvcprRvReThKu0dUTvBQAdI?=
 =?us-ascii?Q?WVETbiWQc80aJzVdI1CbI6WLthCimhMs2oYj8gdgUQcyVySpK6+kWvjJRgH5?=
 =?us-ascii?Q?vBiw7smgdzTsBIHEhoMOhZ+Z2hNC2weoD9yUAFGeFN7a3PrWtltvu9w22r1/?=
 =?us-ascii?Q?dH2M1NXtvKdCZz5kVphnT9oJUBsTibPAt/VZiLOk++F4/x5C58wF/ArP1EEE?=
 =?us-ascii?Q?4fnx+SS+wodmwzdLYe0y+Pw18pJ9TpEEFTySjemHZ75BLOIDpIaTaUNyTJsq?=
 =?us-ascii?Q?zkDzuwF9zcDBvfCARQGaRe4vnCezktWCsFX7FlEmUHRis44zL/30GzHThpae?=
 =?us-ascii?Q?6SnbvqYoP0zeQq8rvY9VnDzRgvq3GWufbB8apRmPdsSEF0DOF42gJInc4K/o?=
 =?us-ascii?Q?7vvg7SoqDcoC9c6YHoG50iJQ+yngf8WzddShZLHLHCEWKzlxd0ypsShNyIMC?=
 =?us-ascii?Q?fjpLTFiYekW7Gfn4/xFVDRo0OlJyPgJnGkekojv845JWZLBc6S0hJUXLUAOd?=
 =?us-ascii?Q?0K9FPAnZ0iIHCAT1bPlGeBZQWwcl3m9jYcdQiF50?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72260259-1c33-46ce-0f85-08de1c854c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 16:06:36.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HT6xbnkJb+3tMumpmvEzyE9xstp1eAap0ntjQkeDMniS6G83hvIbqwH3Okbj8kucdwPsUMCfSCavrht8eZ6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9324
X-OriginatorOrg: intel.com

>> Found by code review.
>>=20
>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>
> LGTM, thanks.
>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to RAS tree edac-drivers branch.

Thanks

-Tony

