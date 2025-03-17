Return-Path: <linux-edac+bounces-3364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EDA6609F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 22:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9652A1780EE
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814CE1FCD09;
	Mon, 17 Mar 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dW4yJueF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59C1DA31F;
	Mon, 17 Mar 2025 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247253; cv=fail; b=JL5nWgODM9S33VQH/gm3SmheZRbY+Sh1N3mwLIvXhey/ZpQWyKLqRPs8c8opxBUMQBftCN/5UzPnU0gaoPOmH08tg2Q7JYhIvPyXiYIeki2mA5kSHE/+xGUjxeO0Xi+w0gaU88JaQq9MU3g9WiF4uB0rLLJVC+b+I4xS48/lhPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247253; c=relaxed/simple;
	bh=01WNxCyhyRHS8y0jTPOtX4F/pcCZ8lVqiOiLiZ0bh00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E6oHLKReht/jRsTRl8dz6glNNbB2uhDTVmsBOo/os+8UMqzb4RACL9Og4oCiBdF5PP97uahODG04wutG5otJKHjEeB4IqiwgV1jifzgxe+unqtyBoNMfKddRdTebFqg+G+W7G/FrC2ZPgRtppAhanFZpP0U7AWn+5uyffynvVi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dW4yJueF; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKJcgxiDQQLqFrp1DqAzwr3PHp+4lM2uZGlb66ylLghhPmCab0nwOMiDu5PU2x/owz9eCETm838oCl1qAI7eoQhhyTU176AnetVT4qltiKJ/TgXpg9OWFZjVrSRdpXqFSyUC+k7gbC+7AxKykWCOpydwqlmU6wnOTiOjSJnAugFHAeV3g9gi1p1EGsxddHH81tiM+fHXorA894sLz7XcuDkFsivGZQ9CdfvNTtGYkQVrbMY7s+2H/oi/Z8Jmhp/MVIdrzzMWgbY61BRAokr6qZ+cnKCWgHLdFqUsT3YSNIdFo+Q2Gvt7uzNI0aRtwbkZM73pw1aWd+2inLl+OF+0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01WNxCyhyRHS8y0jTPOtX4F/pcCZ8lVqiOiLiZ0bh00=;
 b=d4zZyDXCklpyHJnXfcV7uMedrdD7rsAnFvvmBd99EV2CAeHaERUQGtWPPB2NQKgVuJhRvELD+3G8BZ4abnl1v9eO0g8HcqSV15gfXkHHpqQaUd96Hmu/M3Y90TZK10oOUpgK89ecghILxPcUDkbOwu65Z3tf8Qm93Xx65m5jw6TC0dFNz773drg9bDx6SFnHrdzc+wtQ85QTW+FiKuRCMnsdbd7U2qlEcrOmbMHpyT1mu5WyOZtoP+dYX26GFnLzStoEnvgnfBMCviokHw/SLp1iP6ThMCw/GB9mCBiU/wnuxlCVgeJbhSNye57BCPiwwTv9TOGo9SEdwNKC8JUF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01WNxCyhyRHS8y0jTPOtX4F/pcCZ8lVqiOiLiZ0bh00=;
 b=dW4yJueF2Xn+ke2ROvEr2X7zLKuG6mLDmKJCdOxH6VkcIatabjCCbXgHbBXyTpVkprtijxX0rv5D9H4IiLBdgKzvdLDp1Xp7coY3wO9cS29eWlYDmyQAa2qry5BhmLS8NzSlKZ6bra73cATYHSdQL+Nw0oC2/GJVvOktgz68YHj21ZBo0E19lmOv4ulhFDCQyyAPpF8uZF+a76kGejR4ZxJoEIbIDe9nnga8Re7jPjcmBrrQ/yPrBqUBq1uJu6PqcSahsAxNPYK7266gnwNq95OZVOaUdXAZO4O1GWkY58tqjhRYnHqDvlpA0w50DxZVbl9JRG7KeMbAdpprRJhuRA==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:34:05 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%5]) with mapi id 15.20.8511.031; Mon, 17 Mar 2025
 21:34:05 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Shravan Ramani
	<shravankr@nvidia.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Topic: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Thread-Index: AQHbjEvvRVnMwoN/OEGALHJH0b49J7NtPjSwgACKmACACiZ/UA==
Date: Mon, 17 Mar 2025 21:34:05 +0000
Message-ID:
 <PH7PR12MB59028CE9CE0034598F539BC7C7DF2@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
 <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
 <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>
 <20250311103106.GBZ9AQ6u6B8bd6W0Ul@fat_crate.local>
In-Reply-To: <20250311103106.GBZ9AQ6u6B8bd6W0Ul@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|SJ2PR12MB7823:EE_
x-ms-office365-filtering-correlation-id: 7ba24ba8-8cd6-49f5-528f-08dd659b71ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkZ1Zk9TOWhGL0RqTGhyNXFGV1M3cit2T0tZWUJ6SFo0Q3pxK0JwWDBZZ05J?=
 =?utf-8?B?TXgveUd3djZ2aDRqcldqVUNUVWRudVFERDcxN3FPdmZSc0tSNlU2YkdQVWkr?=
 =?utf-8?B?NWd0MGttZVpsRHFIUkVqK2NKVGV0U3hNSG9XcXFZM2p1OWp6QWdMVFcxV3o5?=
 =?utf-8?B?NFNWWC9iOHNEUFdqdm5xbm5zQ0hyWG1JMXJDMy9uMFdBenBoOVBSNGJUdGdh?=
 =?utf-8?B?aFAxY3hLNGoxWHJmVkRSSko0RXVFa1ZRUmcrSW9XSUtwcFowbUhOa29IV0xm?=
 =?utf-8?B?aXlTNVNETzRaeEcwUjNJTU1NcU9jUi9RZDFnMVJzbHB4Z0Z1OURjVEdFU3lr?=
 =?utf-8?B?WHNEaFVzTk8rTzVRaEFHdjhibTYvWTJ0RUluUk5WZkxONXBJYTZ3dWVKbTVy?=
 =?utf-8?B?cDBiWnpyVDg4RWxGVUxDRXF3bTdDV0FFMll5aUREWjBwM2t2NWpLM2VCNUh1?=
 =?utf-8?B?ek5DNmdSanNmd1lxM2ZoTFlQSStuOE9FQzlTNlJ4VGRrU2FSSlhWcHRZMytH?=
 =?utf-8?B?TFJiVmlZTmErU2hNVU9aazc3SFBiY3NDTHJxYmxyTFNqTFJKQzdESHRsWDQz?=
 =?utf-8?B?MXBkNituTU1reHcyQ25WRXRpbUw5MEhIMzNVZjNmU0U0T2srR08ydWZrWEpC?=
 =?utf-8?B?MVVIMEorRDFTT3FNZEJMWWJ6SFMxUTRHVXcwVXY4SVdvbUs3T1NxdFp6WUhs?=
 =?utf-8?B?SHJDUW5EM2tpamhveWNvakU4UGNuSUxWZ0dETmJ0Q3d6dWhFSG41dVd2RU52?=
 =?utf-8?B?UXQ0Yi82dDJ3Q0FsN1ZMazVabTV4cjFubEdtMC9teGNTK1lZaTdSV3N4VVBD?=
 =?utf-8?B?S3VkaEM5SVVCa01jUERxclNIRWQydGNrS1J6TWp6WU12ZFZSRnByMWFqTC9B?=
 =?utf-8?B?d3hrUGcveWxDR0RObmdPM2RiWHFXaDVVdkVyQVUvWUdrSFZlWHNybTUxRFkz?=
 =?utf-8?B?QWJtODBCdEtMWGVjckpvMDNpOTVVWWh6c3lKT2xyYW9uM0R6Z0RNbTdTZEhX?=
 =?utf-8?B?VUlXYjZTYW1obzBldkdZQWhKZjRMOStrSG1iNkFQV21xOTFlQ3N2OUtnRGxB?=
 =?utf-8?B?RkdCdGNNQUxPZ3A0cTNXeHpQblJlUlBMdkpsYnVHUGh4c2Y5Z0NJTmNEMXdq?=
 =?utf-8?B?OWNzeDM1R21IRGlIVXpJRTBtYVAwL3o3d0pOZmlzeEZaaHB1eDZiUGtUZ0NE?=
 =?utf-8?B?ZnNGQ1B1ZTdBQ1pXTi9vRjVXbTJRbUI3ckY5NmRYNGlzd0kyYTlzWkJnTWc5?=
 =?utf-8?B?Q2dUY3ZQMzBXcDZ1YlVJdm03ZDY0ZmFKU3Z1Y2E5RnNZV0c5cXZibFdBZGtm?=
 =?utf-8?B?ZjJCdU1JMzQ3bm92eG1CbGVGNG9BeXhpcWJtM3orNzIvQlg3N2liSiszMmU4?=
 =?utf-8?B?WG1MNlMwZ0NwMmpxTWRQTmZuTFNMT0srcGdjaHdkNGRUazFpZzdsRVJTbEta?=
 =?utf-8?B?Z3hRTktSbk9ZNVZCYzJIaGM1RVRYeEVUZ3VFRHlCWGY4U25md01GNW14V3Jp?=
 =?utf-8?B?N0s5eWdmTCtFNDhBdmJYaE5zWW5oTkNUUGlMd3ZacE9TYWsrR0JIaTJCU1Bp?=
 =?utf-8?B?UHJWTkI2YW1ZN3QxZld3cWt5UWxJS3pNRVZTUjN0REFpZ2VzR29BemVwQW1F?=
 =?utf-8?B?RExtbE5MZTRMbnFRenZ0OUZEV3FXa0pKZG1BVFF0UnpEUW9QUHp3czFMWk5L?=
 =?utf-8?B?NGVRa2QyaGJCbEtkQ3ZVSWg1bU1GdmNyNzh3alNlSStsZjJOUjlPeTdNbDFp?=
 =?utf-8?B?TXVaSWVjL0xlS1JsK1pKOTU5WjBybWljNTNBcTB5SFF2dXZWdHpQNHJMUE50?=
 =?utf-8?B?UDJUeVpzM29PSjlSb3l6bjVyMkJ3MXJJSjN2dzhocXViNE5iYnpuY2w0SGlS?=
 =?utf-8?B?UUNjVzAzMTZ1RUtDMHlyc1V6ME5EUWw3REtMZVozVUZDQjJYaXlZeDhsa2hB?=
 =?utf-8?Q?Ota9izVypYJZP6GtGgbIeZtzJTeL4rDC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzczYURXN29HZGlVZnQ2amU0bTRUZC9na2xSblhkcmJ4VWUvUEtRb2ZKS1dR?=
 =?utf-8?B?VWFyUWt5eWluY3VZRERwdDRVdkdRQmh2bVNCQjBXUHRjanVnRWYyUnNuQXVO?=
 =?utf-8?B?UW8yektPNWllWkY5NHJzUGFnZk5ScWh4SUZDK1d6Q3V5c1FFOXRKUlVqS0gz?=
 =?utf-8?B?U2hld3M5SnRlY2xzbGUzR01vWDkra0JKN2hyYnplSkJNL1hXd3krNk9sdzht?=
 =?utf-8?B?TjkrbU0wK1hFWHJ3dm56TmR4eXA4MVpreFFyZlQvNjVKL1QyQXF4N05MQ1lP?=
 =?utf-8?B?eTd4Nzh1dUpSUDhwRVlDeHhqUU9SZWpVbmhzdUlzUno1YWduNWhJZzVSa1FM?=
 =?utf-8?B?eGh0Y3VEdTZ0YU9iU29rMmRVaUFnTW1xT0ZvblcxMWJ5NU4zd0p1Ny9tQXV0?=
 =?utf-8?B?NVhyNzVTT2xOZ0pJYytLb2pHY2Yzb243QW81T1pGbnl4TmVzOXdIT0hYVnpj?=
 =?utf-8?B?R2FrVU5jTkhWNkRLdFhSMnNXelIySGVIWVNydWtGczYzYVlsNGtWVDVTZmNN?=
 =?utf-8?B?MVBRY1FvYWV5eDRXNWNWTHJ5SHUxYW1wYW5rR3pqckIvNzE2djhtRU9hTVd4?=
 =?utf-8?B?NWdiNUJzQytZUmJpTmF4dVFNZ2hDYW96NjMzVkJPTjdobUFVcXRkejNUVzhM?=
 =?utf-8?B?TWRnVEgrRCtVVzdhanl0VCt5NGV6bTUxM2xsK0pJbnF1ZW4xazEzSnJtQTJv?=
 =?utf-8?B?bCt4SHpqT2FZejVEVW1rUmdEcDdqVEdnaDg1anJJMEJpWDNzaDZsOW15MTNM?=
 =?utf-8?B?bjh0SFBlTHRFTEhGMk5maUhicy9MSVZTT3lEZHVObzduQjR2ZVBCSHlvNCts?=
 =?utf-8?B?MGFLYjhVQm9PeDNVWTM5aXlwUGFlUmNkL0M1a2lqSHRGTXpxNmh0bWlaRHFR?=
 =?utf-8?B?Q0o3a3QwTG53aFQ2amI2dGdlOTZ1TDViZllPRExRMi9zeTE3N2x6b0FZUGJt?=
 =?utf-8?B?MytGdlVLditmU3QvT1AzbFBSY3M3dFNBbmRMYnhNMFlvdGtrSzNLL2xyUFNM?=
 =?utf-8?B?Vkk3SXRVSHpkMlppUk1wTUtjU0d6NksxMkdTU1d4ajZTdTVDS09adTVQcnFZ?=
 =?utf-8?B?WmpkNVBEcE45YlZVcWE5cmx0em96SGx6SGlLVTlmejhlSG1taFoyYWxIcVM5?=
 =?utf-8?B?QjVMUXB2d29mVzlMVzI5dmNRaG9XMFZMenNNZjFGeDlCcUE0ZUk4bEozeGFx?=
 =?utf-8?B?UWU5WUp4RXUrRTZaSjJSYUVOZkc2OTQxVFNzS3FiTUV3ZThIZkFsTENrMEpB?=
 =?utf-8?B?RjFnTVdJVDU0emVtazJ5ZlJKbmRaQnJYV1JueC9YelhjdzRITEw3ZWN6Y3d6?=
 =?utf-8?B?M1h4UHNIVWZ3QkZZOXJuc3BFWGpmZW9JM2I4aXJDZkRHNTMyYk0zU2ZhaTFn?=
 =?utf-8?B?VWVPVEJyZE41RzdKd0lYb2tqQS9qNmtJdHYrRkJxMzdpVmtYRTVjMXVSUXB4?=
 =?utf-8?B?Rkl1c3I5Z3Q5N3RMVExXdEtvK0FQejl2WnNFbEhVeXdjMG9BTnpidDNYV0p4?=
 =?utf-8?B?WjZlVlZRaWJpV09vSG45ZWdleE5xSUtYc1gxaVZnYitqT3lGRGhESStSenll?=
 =?utf-8?B?N1YrZk9nYzIvRk5OM3loOUpsTDNCRmZQdFV0SHp4bWFCVTRPWG8wUVkvYXJ1?=
 =?utf-8?B?THBqbFVuVW9uclNJMlBUdkhna09zTGY2SXF6dnAzdzlTSjQySmt2S25MMW40?=
 =?utf-8?B?cS9uU3FRVGo4R01HSVdWOW5EaktQeHM4NVpvVyt2K3o3cHcwVEhNUk1TYXhH?=
 =?utf-8?B?TVBoU3VIOFdrcGZqVEFBSE5zYUZyTUczSm5rLzE5M2dRajFEWkozaTB1Tm9W?=
 =?utf-8?B?b1ZQMzBWZ1BIT0w0cmhjbW9vRk1TbHptUWhmODFZNHNRM0NoN09XTVdFa0Ja?=
 =?utf-8?B?NGx3TFQ1TS9nYnBPWkJYTXBWZjh3UmlzdG10NEV3TWlMOGVrTndSUi9wTjZQ?=
 =?utf-8?B?UlpmeXdYVmdLK2pFd09QK094UnQzODBaTHFwMXJCMHM1bHdzMnNiNDl5ZUlF?=
 =?utf-8?B?Z3RqclZCbUUyZjhPa1JDcEFKTG42ckpVZTZwR1hLYTM5UDZIS3RYT1NwQzhI?=
 =?utf-8?B?Rldzdm1BSGhiY1dsT0FEZ2hoWE1UZCt1NkhSWngxcHEvRmg3czlHTFlGMUxG?=
 =?utf-8?B?VFdlS3lZV05tTWZtNncwdi9WVENQaFE2NkRrL0N1ZEhyVGxzK3ZkaWpmQStS?=
 =?utf-8?Q?x8v4C9ctKMa1PPNum234E+fUBT0D1m2FrzjT7G5RPR3L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba24ba8-8cd6-49f5-528f-08dd659b71ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 21:34:05.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwPaBOixngvqZp1ZJe85cg0HsvvDgAi6kmuWj5wHvgywPne0EmtVSKbd5uTe91XU146yHiCIW8dvl4cEfuQjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTEsIDIwMjUgNjozMSBBTQ0KPiBU
bzogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5jb20+DQo+IENjOiBEYW4gQ2Fy
cGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+OyBTaHJhdmFuIFJhbWFuaQ0KPiA8c2hy
YXZhbmtyQG52aWRpYS5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGttbCA8bGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbYnVnIHJlcG9y
dF0gRURBQywgbWVsbGFub3g6IEFkZCBFQ0Mgc3VwcG9ydCBmb3IgQmx1ZUZpZWxkIEREUjQNCj4g
DQo+IE9uIFR1ZSwgTWFyIDExLCAyMDI1IGF0IDAyOjIyOjIwQU0gKzAwMDAsIERhdmlkIFRob21w
c29uIHdyb3RlOg0KPiA+IFNocmF2YW4gYW5kIEkgd2lsbCBpbnZlc3RpZ2F0ZSBzb2x2aW5nIHRo
aXMgJ3NtYXRjaCcgd2FybmluZy4NCj4gDQo+IFRoYW5rcywgc291bmRzIGxpa2UgeW91J3JlIHN0
aWxsIGludGVyZXN0ZWQgaW4gdGhpcyBkcml2ZXIuDQo+IA0KPiBXaGljaCBtZWFucywgSSdkIG5l
ZWQgZWl0aGVyIG9mIHlvdSB0byBiZSByZXNwb25zaXZlIG9uIHRoZSBNTCBhbmQgcmV2aWV3IHdo
ZW4NCj4gcGF0Y2hlcyBsaWtlIHRoYXQgZ2V0IHNlbnQuIE90aGVyd2lzZSwgSSdsbCBzaW1wbHkg
b3JwaGFuIHRoZSB0aGluZyBhbmQgaXQnbGwgYml0cm90DQo+IHVudGlsIGl0IGdldHMgcmVtb3Zl
ZCBjb21wbGV0ZWx5Lg0KPiANCj4gU28sIGlmIGludGVyZXN0ZWQsIHdoaWNoIGVtYWlsIGFkZHJl
c3Mgc2hvdWxkIGJlIGluIE1BSU5UQUlORVJTIHNvIHRoYXQgaXQgZ2V0cw0KPiBDQ2VkPyBTaHJh
dmFuJ3Mgb3IgeW91cnMgb3IgYm90aCBvciBzb21lIE1MIHlvdSBndXlzIHdhbnQgdG8gYmUgQ0Nl
ZD8NCj4gDQoNClNocmF2YW4ncyBlbWFpbCBpcyBjdXJyZW50bHkgbGlzdGVkIGluIE1BSU5UQUlO
RVJTIGZvciBibHVlZmllbGRfZWRhYy5jDQpNeSBlbWFpbCBhZGRyZXNzIGNhbiBiZSBhZGRlZCB0
aGVyZSBhcyB3ZWxsLiAgU2hhbGwgSSBwb3N0IGEgcGF0Y2ggdG8gZG8gdGhpcz8NCg0KPiA+IEkg
c2V0dXAgYSByZWNlbnQgbGludXgtbmV4dCByZXBvLCBpbnN0YWxsZWQgdGhlIHNwYXJzZSBwYWNr
YWdlLCBhbmQNCj4gPiBkb3dubG9hZGVkICsgYnVpbHQgdGhlIHNtYXRjaCB0b29sLg0KPiANCj4g
QnR3LCB5b3UgZG9uJ3QgcmVhbGx5IG5lZWQgbGludXgtbmV4dCAtIHlvdSBjYW4gZm9sbG93IEVE
QUMgZGV2ZWxvcG1lbnQgYnkNCj4gZmV0Y2hpbmcgdGhlIGVkYWMtZm9yLW5leHQgYnJhbmNoIGZy
b20gdGhpcyByZXBvIGhlcmU6DQo+IA0KPiBodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvcmFzL3Jhcy5naXQNCj4gDQo+IFRoYXQncyB3aGF0IGdvZXMg
aW50byBsaW51eC1uZXh0IHRvbyBhbmQgRURBQyBwYXRjaGVzIHNob3VsZCBiZSBiYXNlZCBvbiB0
aGF0DQo+IGJyYW5jaC4NCg0KT2ssIHdpbGwgZG8gZnV0dXJlIHdvcmsgb3V0IG9mIHRoZSAicmFz
IiByZXBvLCBlZGFjLWZvci1uZXh0IGJyYW5jaC4NCg0KPiANCj4gSG9sbGVyIGlmIHRoZXJlIGFy
ZSBxdWVzdGlvbnMuDQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJv
dXQtbmV0aXF1ZXR0ZQ0K

