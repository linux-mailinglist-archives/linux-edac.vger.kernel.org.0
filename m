Return-Path: <linux-edac+bounces-3495-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5AAA81C51
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 07:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C01B6588A
	for <lists+linux-edac@lfdr.de>; Wed,  9 Apr 2025 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3827C1DD525;
	Wed,  9 Apr 2025 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UrTdP1Jf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA11DC992;
	Wed,  9 Apr 2025 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177744; cv=fail; b=d2Krve2oBtJOS+HcbYXq0/rlu01NybOjrkZb2yplNSsUvlBVgvJc+gSlar3n4TZYo4bZwEpj3A9n+tSAzuewjymjT0oSUcCONwk9Vjj6h1YFY2MnZq4y6amhRp2s8i/IMfTN5srtoiPclUC4GV0FT2HJgXtghdcq5ocpFAnowhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177744; c=relaxed/simple;
	bh=+bjIsin8EzNg91yC0OiBugyICF+3ZiOYyRkE3mrCgEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aT4A1gt2/M1dBg1Raj2rtSiLyoAP7Mqo+wa/en9ghJEySHyzIHRw1OBi+9g85P5KNTe4sEObgPAFM6VhYYb5x0p1TMezwGGoEMsAVsgI22xEcDUvoZaHs7moD6pFwxRQaX228hd5TuqZbtSiLnaJXimkvFLNsGbEfsalROf70WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UrTdP1Jf; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoQFhtDG5MuB4/1XpcjELBlrz8+SkCk8L83r8YU4JftsTmguQ30QfN1lPL97pK5qPkPgrUO1BSX7us3FuEV+MHtxXkSfN8sbo4FCWaLDj7t5JlnGnZpSixXNtF+9/5/bIPYMmmMTJSQAhNS+xz5xfiiZ+glTyHOE7sx7up1JrAFYX6tE9joP3kqKhUse0th+6pjWp7IX/lvKCAwt53XBVr5CBeQdQPfWJY8zfY5aeyS2MviIHtoUmMqwOYoera+sS1bOSyrKn6RRkTIyNQ6MjZ+G2J1vf+f/8VzhPMYlKeQGiETWOBvhVc4mPFgkKuyjJPmmK72NK905NB2Xv/t8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43NfRBzydiSvxdrmnyCp7wmYsibC1SwbEjie+7lOXpo=;
 b=MJDwiEH679+HT7FeoVfYH0z4t6UV3OBNU2sTnDa0rGxrWAqdpgraS9mt2l9RHdsmyZZdJDGLBYn+CW9CKMP4nOvbwWY8z6qdiNrudSoiTedvg2DC8yQAQWJJOe12prPlr/GG+/2X2O2ZdaJvFld6q2i29OBmlkqR5Aw+XRxHNvPF0GnZD7bY7hd7xhwKyRmje1b5ORlgoFIRgk9nlAsUn+TCeUlYN68EupxQTZyBXW0igs4msURO6dM41ULrMBy+mdPbB2FGHsQjJg+u496gBN+zD3t5b3FNNZcRGTUU7yBEgstdm/Nk3NO5ioifE9ekNeivBef6Bi+zvfvPNufsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43NfRBzydiSvxdrmnyCp7wmYsibC1SwbEjie+7lOXpo=;
 b=UrTdP1Jf7dH3pGp3sIcCQZu/IkJkKdllOlOwPQKlgJpEX36LVoY+8kCbpPuvFrI8o/ZGjfKTbPnu7Y05/JjveVx9h3I7j6nUsJs+49NOzsEscCab8yS12vY9lnYZ4kBINevJ36ez/zKS5Mwg9b9w0MyB6daLzK+W1PUENnSeTg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 05:49:00 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 05:49:00 +0000
Message-ID: <642236b9-a19f-417b-bf1c-888ca54cecca@amd.com>
Date: Wed, 9 Apr 2025 00:48:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
References: <20250327210718.1640762-1-avadhut.naik@amd.com>
 <20250405005832.GA1625290@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250405005832.GA1625290@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:806:126::24) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: f09646c6-ff34-4ce5-5ba3-08dd772a39ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0lSVWphYzN6cHlaODZvWUdPRlc1ZmJGN0RSYk9QUDYva1JZVjE0VkxXTUJO?=
 =?utf-8?B?Y3l1Nyt1cW91M29pblNFVEdhemhPelJ6Q1NGTmNrMW1WZ0VxU212MUVuTHZh?=
 =?utf-8?B?YnZjT0xwUjIrZWtBUGJLMjByNUFFS0VFL1F6cnNRQnJrZytHSkdhVXByUCtW?=
 =?utf-8?B?MGdiS1greUo1ZFNCMXRBNHg0bHZwZnZZakNubXd5bTRkNzZzQ3hySEJuNUtW?=
 =?utf-8?B?eDJUcmlObXdtRG9nSDhYUkMxZldOckEyVDN6YTd3MkMwL0VEZkJUTGd0NlZ2?=
 =?utf-8?B?VXhKNG9NNlYvNk1LKzMvaUE1dGxaakpFSThmN2NwMVo0bUtlcERSL1ZQTUpP?=
 =?utf-8?B?YnJJcllrc205dkpTME82UWNabTVPbVJiOFhBN3JuTW1MU0Q5SisxZFJabita?=
 =?utf-8?B?Q1kwckZIU3ZyNWVjY3ZkWmwxZXRPeElnUkZtOC82WkJicmxPOTR1YmV2eW4z?=
 =?utf-8?B?d1dBSFFYU3hLSXhJa0xOVTZOUEpHYitjM2J4UDdCb3pRYXdJcGpGcitETFQx?=
 =?utf-8?B?SjNOdVY2OSs5NWt6VDdVYUhwQlBNKzUrYjlRUG5xOUsyemhyWEpjazEvd1cv?=
 =?utf-8?B?MEwzKzNGMXAvWmNSNU9oVXV3Ykw1cm04SkJqMjdWcUxod0NHNjVNRXROcklp?=
 =?utf-8?B?eU11UDVlWXMrbmVVVVM1b0JkNXFDNiszVWlZZkRyTjFZMkM5OVp6MkdSeXJj?=
 =?utf-8?B?VkpqYU9BNVF1dVVzVzlvOE5tV2FuZ0VjMG9pVlc1dnJNYUdNTkVDeXJuK0gy?=
 =?utf-8?B?cnlieGtBUzNvdnN1Qll4Q2lSUVJpRkQzR0xxc0w3ZzZsSFVZaG9kdXpaUTNJ?=
 =?utf-8?B?ekhjQktONkFBTS8wNytvR1M0WDl3U0dZYnZwcGVjZmQ2bUZXMHE0NHZHSTZM?=
 =?utf-8?B?VFlMK1FCRnl0djQrb1hZcm5KbkI4STU0c09kZURkbjBTWnBYRTBhcnRjSlpi?=
 =?utf-8?B?TndlUWdpL0RTNHh1L0k1cUFyMmJNQjNmTyt2ZW84QmpocTdtZzkyNExtL3BF?=
 =?utf-8?B?cjdxS2VkQ2dlb0xKNVFDbWF0cXJkVUJ4VGhHbnZqZnJvazRhMFpxVWpGclpl?=
 =?utf-8?B?NklaZ01ZVFFFa1FvaGhQWjJkeTArakdUUFFZMVpjcFlJS3NuMksvUEt5SVdY?=
 =?utf-8?B?MkpoNng5ZDVGWWZJL21lSDRGVTBiVU55eHgvL3ZnYUZ2QWFvc3VzbHdJR0h3?=
 =?utf-8?B?MlNtQ0hqcW9VOVV5a2lUQWJ4amFXVGlqVkYzTk5tQ2xGcGtDejRWT0dTTTI2?=
 =?utf-8?B?UzNXcWdGREpQSk9mQmZmVVdqZzQrMUhWNGNpanJQbTNQc3ZpcExXZDcvMStF?=
 =?utf-8?B?eExJaytuMGlXM0xTbXBua1F1TDhtYXNYVWNaaThqSDVPdU5VNnBnSC9XTklv?=
 =?utf-8?B?NGZCdFNtblFXQ0lhN2dzcU0yWGdKT2hLWC90YjhUTUN2OE5XWEp4VVZwMTlj?=
 =?utf-8?B?Vzczam04eXJlNVNUenNCNjJaL1ZvaVZHbmdiNnlLb29tbmMyUWVRNlgzdDdi?=
 =?utf-8?B?OUJJQlJVcW8yblRtajRQdGdmbEMwc010Ym9iSlB3bVg5TkVyVS8yellNSmh2?=
 =?utf-8?B?UkNER3EyNW45Nmhuc3ZqRUxRbUFGcmJldXdYbVJ5c0NBckN5RDB2cGdlR2Fs?=
 =?utf-8?B?eWZpanZ2ZDU3SlN4eS9BekNFTlNDNG1IZkpZZkFvMThBK1liajJFSU5JZzh0?=
 =?utf-8?B?V1JJcmJXaXZEYjllNzI0Y1JrUEdlMVlFZDc0b1g5di9nV2dUZHdrSUIzRzZo?=
 =?utf-8?B?Nkw0S2w0RG5WTEkzdDJVeDFBRTJBOTRUVHNGcytrUXcvWjBhSGhuY3lrL21N?=
 =?utf-8?B?aWc4WlAvYUU1NWRoZkY3SUt3aWc0dm1HTlR1NTBWd0N6NGZTVThEalM5TE05?=
 =?utf-8?Q?LNNEPsYYiH7jJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVGa1U2Tjg3ckJQVWZuRTNqaUFkQlZQck1vdElBMVdKZ0FNdFNoVDhOUkNK?=
 =?utf-8?B?YjZ1aUU3OFhCbmdZUGtFMTRjMEs0YnNZU0E3aHZYYlZvRVhJMGE0MHNOZWdQ?=
 =?utf-8?B?bnlEb0JWekZxTFJSUDN5c0N4VXhELzhIVjF4RWVTV3JSRVppNWhQRFNpWHVT?=
 =?utf-8?B?QmN3bzR6UHJTNStON0RkSE1TbGMrK1Z4cE9ock5uSm94ZUE2Zm4rZmJPd2F1?=
 =?utf-8?B?WmJvdzZET2VqQzh0Z1I1aE1lWkxDT0hCWXJXQ2NsQVBmQWhSZHJCY2twbUxP?=
 =?utf-8?B?Q3doTFVyWVdBaTY5czNQUUlBVGp2VGZPZnltWm1CdHIwWFUwTWRMSjF2RnIz?=
 =?utf-8?B?UkNpcTM2SyszRE15aGZrNWhXRGhUbzN3UDh1WHZyWmdjckMwUzJoajFmWDJz?=
 =?utf-8?B?eVpCSUEvZjFqUjhtYm5NQmphZlQvZWpNaVZsbHZWK2RQNmtCT3JUWlUza3Fx?=
 =?utf-8?B?R0NtVEYyZmVScTBUU2kwaGgxNUs1Z2NoNHYzYU5xZFVJYllreGhXdmp0alYw?=
 =?utf-8?B?ZVJlRzhXUnFzeU44QzA1R0p3RTFwZXZ0M1ZFZ2NBZTNNWDVxMEJaRENrZDll?=
 =?utf-8?B?S3hzUTF6emx3ZVNReFFra1h1K2ZDZFVPMkdNYzNBNVhWcEhnWFlnZjdIb1ly?=
 =?utf-8?B?MVhMakpjcWZ2VWNSalZLNmRVVjFSNGdkSVQrZndkVmMydjFCeG5pK09uN3F2?=
 =?utf-8?B?NUYzMWRtZ1crSHU2YkFHeFk1VmczeXY4ZjYvK1UySUtEVzZVVjArUUFPWmZi?=
 =?utf-8?B?SXo4eUhySFpPRzZEOEY5RHE1V2hKdFRHYjJ3TEtxVWp5NWd4cHFOd0QvemU4?=
 =?utf-8?B?R3lleVdTN2hGU2MzaGxpc21iamxnNDFUZklRN1JJR0hhdThUN0VPQ0V4UVQx?=
 =?utf-8?B?cS9sUDFQMFRkUjllbjFwRGVWclk3WWx5TzZXYWZ1UEdMRHMvRnZ6RlRHN2dD?=
 =?utf-8?B?YXVtRjRvMEo1UGFtOHZoSy9YYzBiVlNCTitVKzJwMzNTaWNrN1dVdUZJRlBF?=
 =?utf-8?B?a0lrTWlKMi9Cdk11UXZEeG1PNHBkWHZieEIrNzdpSGwwcmovRCswOXdYSm4w?=
 =?utf-8?B?UG5ERzdlUHF2b3BqSHlRZFNrZjh2RThRUExma3ZDektxSnZGeTR4M3plRThr?=
 =?utf-8?B?WWpBTUVvd1AzeUtsZjhnWG1DdUEvbTgzWEhGaGV0UEpEUUk1VE41SllIS2hE?=
 =?utf-8?B?R1cwSlZNSFZCc0x5bit2cUlCRjAwUjdGUlc4bGg3aytvMWhOV04zcHF5YXFC?=
 =?utf-8?B?OXN5NU9sYlVseENaWjdVM0RIZTljSVNTRlluTGNzcCtuR3ZodjlSMGF6ZC95?=
 =?utf-8?B?QU4zalNMWE9hTFQra2Q2UzhndnVUeUZ0bGhqZVAxQ3hmUi9kS0hyVmVWN1Rw?=
 =?utf-8?B?UFlmUENEb2dyNG81KytZc0RKMExpb0Qxa0YyRFFqVFcwRTJMcmNiVTlScmoy?=
 =?utf-8?B?MlhnU1VrNVlBcVMva2tURXRUeG5TQm1hVUlIdnM1WVptQ3hDbzcwRk9BWG1v?=
 =?utf-8?B?alI4TUhLcUp3dDdNaDVBdU84N1JheEsyWXlIWEdXRVlFMFZpSEhHcE9YZkZt?=
 =?utf-8?B?RmpGT2orN3p1MEFRdTJCTHM0dkFHdG5wQnI4Tjd6K20xMlUzaldJTGtXREFM?=
 =?utf-8?B?cVBzVTZZemt5UjZ4bFpNWFpteExuQlRRTlYxbmY1Ymwvc2c4ZDFabFZDaFJK?=
 =?utf-8?B?NTZQdFhVMnV0S2puVkpmWWJKUk0wVzE1Mjl4eFVyWm1QeE96cS9LMWUvMUNy?=
 =?utf-8?B?WDNnTHI4NFMybGRKWnI1RDN1c2ltY0tNVmtnbmF2OGI1Ykw5WHJTZFZjb3Qx?=
 =?utf-8?B?dlRFRldyMk91R1BVeForNTJQZ2lBbFVhaEs0Z0c0b2hLS285ckhQTUtHWUNw?=
 =?utf-8?B?Z2tlOWpGaytxVVN0UlcxRzEyQ28rVnRsRk80UzB6Ym5DUTBGdkdwYlBrcExv?=
 =?utf-8?B?R05nWWhwclBVRHh1Y2JyQVI3MGJXcGNxN1RVUUhkK2VBbkFoMEhKanpQa2Mx?=
 =?utf-8?B?Y1V2ZDhzZzdUSERpMjVHbnIvK0pJS2h6dnRZRXVRZDJUSTlBaXJ0NkRnZjZ2?=
 =?utf-8?B?SkgvU0tQbnY1cVlmTlJjSDU0VS8rNkRjOVFVMGE0d0VkV1IwSjN3L0xaUTNk?=
 =?utf-8?Q?TiUq3iE2zwaqT0+tMf7MpwIhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09646c6-ff34-4ce5-5ba3-08dd772a39ab
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:48:59.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi8v82u7HcKDYPIW/GyXTJ8R2p3pAaBxGLRXpppU3HUqXJjmXtW6Bvyq7an75nH2EcC4vSTcCdSdrCjCtu+J5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984

Hi,

On 4/4/2025 19:58, Yazen Ghannam wrote:
> On Thu, Mar 27, 2025 at 09:03:50PM +0000, Avadhut Naik wrote:
>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD EPYC
>> SOCs has an Address Mask and a Secondary Address Mask register associated
>> with it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS
>> granularity during init using these two registers.
>>
>> Currently, the module primarily considers only the Address Mask register
>> for computing DIMM sizes. The Secondary Address Mask register is only
>> considered for odd CS. Additionally, if it has been considered, the
>> Address Mask register is ignored altogether for that CS. For
>> power-of-two DIMMs, this is not an issue since only the Address Mask
>> register is used.
>>
>> For non-power-of-two DIMMs, however, the Secondary Address Mask register
>> is used in conjunction with the Address Mask register. However, since the
>> module only considers either of the two registers for a CS, the size
>> computed by the module is incorrect. The Secondary Address Mask register
>> is not considered for even CS, and the Address Mask register is not
>> considered for odd CS.
>>
> 
> Missing an imperative statement for the major change.
> 
> "Include Secondary Address Mask register in calculation..." or similar.
> 
Will add a statement.

>> Furthermore, also rename some variables for greater clarity.
>>
>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Cc: stable@vger.kernel.org
> 
> JFYI, the TIP maintainer's guide recommends *not* actually sending the
> patch to the stable list. Though I recall some stable maintainers are
> fine with, or prefer, this.
>
Thanks for the info!
 
>> ---
>>  drivers/edac/amd64_edac.c | 56 ++++++++++++++++++++++++---------------
>>  1 file changed, 35 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 90f0eb7cc5b9..16117fda727f 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -1209,7 +1209,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>>  	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
>>  		cs_mode |= CS_ODD_PRIMARY;
>>  
>> -	/* Asymmetric dual-rank DIMM support. */
>> +	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
>> +		cs_mode |= CS_EVEN_SECONDARY;
>> +
>>  	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
>>  		cs_mode |= CS_ODD_SECONDARY;
>>  
>> @@ -1230,12 +1232,10 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
>>  	return cs_mode;
>>  }
>>  
>> -static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>> -				  int csrow_nr, int dimm)
>> +static int calculate_cs_size(u32 mask, unsigned int cs_mode)
>>  {
>> -	u32 msb, weight, num_zero_bits;
>> -	u32 addr_mask_deinterleaved;
>> -	int size = 0;
>> +	int msb, weight, num_zero_bits;
>> +	u32 deinterleaved_mask = 0;
> 
> Don't need to initialize if it is set before first use below.
> 
> It doesn't hurt, but we might get patches to change this. I forget the
> exact reason; maybe saving an instruction here and there adds up
> throughout the kernel.
> 
Will remove this.

>>  
>>  	/*
>>  	 * The number of zero bits in the mask is equal to the number of bits
>> @@ -1248,19 +1248,32 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
>>  	 * without swapping with the most significant bit. This can be handled
>>  	 * by keeping the MSB where it is and ignoring the single zero bit.
>>  	 */
>> -	msb = fls(addr_mask_orig) - 1;
>> -	weight = hweight_long(addr_mask_orig);
>> +	msb = fls(mask) - 1;
>> +	weight = hweight_long(mask);
>>  	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
>>  
>>  	/* Take the number of zero bits off from the top of the mask. */
>> -	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
>> +	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
> 
> This change makes sense to me. But it would be good to mention it in the
> commit message. This is more than just renaming variables for clarity.
> 
Noted. Will mention this in the commit message.

>> +	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
>> +
>> +	return (deinterleaved_mask >> 2) + 1;
> 
> Also, 'introducing a new helper function' should be highlighted in the
> commit message. It doesn't need to be a long description.
> 
Okay. Will mention this in the commit message.

>> +}
>> +
>> +static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
>> +				  unsigned int cs_mode, int csrow_nr, int dimm)
>> +{
>> +	int size = 0;
> 
> You don't need to initialize this since it is immediately set below.
> 
> Or you can just call the function here.
> 
Will remove the initialization. Calling the function here might make
the debug logs confusing.

>>  
>>  	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
>> -	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
>> -	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
>> +	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
>>  
>>  	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
>> -	size = (addr_mask_deinterleaved >> 2) + 1;
>> +	size = calculate_cs_size(addr_mask, cs_mode);
>> +
>> +	if (addr_mask_sec) {
> 
> I think we can skip this check.
> 
Commented below on this.

> For debug messages, it doesn't hurt to be more explicit. So printing a
> 'mask: 0x0' message is more helpful/reassuring than 'no message'.
> 
>> +		edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask);
> 
> addr_mask -> addr_mask_sec
> 
>> +		size += calculate_cs_size(addr_mask_sec, cs_mode);
> 
> Maybe add a "!mask" check to return early if you want to save some
> cycles in this helper function.
> 
In a way, this is the reason why I had added the above condition check.
To avoid unnecessary function calls.

AFAIK, power-of-2 DIMMs are predominantly used, so the Secondary Address
Mask register will seldom be used.

Would you agree?
>> +	}
>>  
>>  	/* Return size in MBs. */
>>  	return size >> 10;
>> @@ -1270,7 +1283,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  				    unsigned int cs_mode, int csrow_nr)
>>  {
>>  	int cs_mask_nr = csrow_nr;
>> -	u32 addr_mask_orig;
>> +	u32 addr_mask = 0, addr_mask_sec = 0;
>>  	int dimm, size = 0;
>>  
>>  	/* No Chip Selects are enabled. */
>> @@ -1308,13 +1321,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  	if (!pvt->flags.zn_regs_v2)
>>  		cs_mask_nr >>= 1;
>>  
>> -	/* Asymmetric dual-rank DIMM support. */
>> -	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
>> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>> -	else
>> -		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
>> +	if (cs_mode & CS_EVEN_PRIMARY || cs_mode & CS_ODD_PRIMARY)
> 
> Another common way to do this kind of check:
> 
> 	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
> 
Will use this!

>> +		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
>> +
>> +	if (cs_mode & CS_EVEN_SECONDARY || cs_mode & CS_ODD_SECONDARY)
>> +		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
>>  
>> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
>> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
>>  }
>>  
>>  static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>> @@ -3512,9 +3525,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
>>  static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>>  				    unsigned int cs_mode, int csrow_nr)
>>  {
>> -	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
>> +	u32 addr_mask = pvt->csels[umc].csmasks[csrow_nr];
>> +	u32 addr_mask_sec = pvt->csels[umc].csmasks_sec[csrow_nr];
> 
> Please align on the '='.
> 
Will do.

>>  
>> -	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
>> +	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
>>  }
>>  
>>  static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>>
>> base-commit: f1861fb575b028e35e6233295441d535f2e3f240
> 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


