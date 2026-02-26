Return-Path: <linux-edac+bounces-5752-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOO/HmiFoGknkgQAu9opvQ
	(envelope-from <linux-edac+bounces-5752-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 18:39:52 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC41ACA1F
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 18:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DED9E3493EA3
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8798B426EBC;
	Thu, 26 Feb 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PqsE1YQs"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4A3290AF;
	Thu, 26 Feb 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124629; cv=fail; b=fPnDoBow4hlmBZ98Vln4gV42J+G6zLyksQ+MTp356DrdB2rDFDsJgPHp+onn7Vb0e+dR3CWRmNwgyDbyk/OfXPFTptseGzbQpMU990yQPt7uEVWEF9GZ3LnRQojnWLbPJhGRJXZpPWU1tGlZCwRKJoUdr2u+G2fsxXZi4izj1KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124629; c=relaxed/simple;
	bh=FjwHhBVgEiFSosTIYZUtui1it6DbbhxZoSQISqV699M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bC9AFvnKD6tdww6BT2zXDuG0q23tZzXWuIrHnYBv8yWG+PT5m39hk4qbw0Gpo0cL0hqHYDjshbXa8O1t3YnmA0T7jyNosQOy84+jEo4LDZTI08hnlN9qjvSaziPwgYvYjjxHYJIeNjnJClZwi+bcx9oG/Db2QjP7DjzXWS0w/GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PqsE1YQs; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW1Xj2XktuLPBf84aw83Zfc374FdNy99NMsOiHu5y8heXc+3Lh7RIQ+q/GqeV3jXoGTTJs1kVK7q3eRa1/wUjRkw8JLj6W7QHSiFECJD1b6PLgj1Q9DJZmOgN7y70I0S+K6wMJJNBE8W/316K2oqd1nA1FjdhvJeOD2gzJwc3Ow3LIKjqo6RyDwymDjIAp9PyuCQaOdwYHintHowmu1dO3BYMYYzyGVhXNWSDnji81uTzlLNZqbif+NKUf3Z8EdkbJWXNt0Eaqs8I/JzDUBczYnUM9ZmTZDaq4NpsEg4F2v9R8RWlyB/mahvqk+Z8+q+85Buvk190yfXkhCNQdn3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjwHhBVgEiFSosTIYZUtui1it6DbbhxZoSQISqV699M=;
 b=qvh/SN2XBeiFzmx2XjBnhm4uw9N40nAVT7zH0BQz8G6pF18Q2N09TexwJ1+CohEwnqyQMcBJ4b5/mGJDfb2GMS/De23sPwdDpxHfVKHi5mGr5ImPeZEaVv5+3bygOUOEi/lNMxybbHHLRGBUntNATFGEMUnO5+7tzLaTTFIDplmg0EznSvluUZXj1VbDGWWZdoPawrwoyz3IWME9fuAlB/8JtIhKaLzi1wuY1w/gEotRT/mowO6mnuRw2JiNYxo148LtvVuHx6gJ5uN61/VGyl/DW7YKfD6QjkDp3Qa/jghgg5n2Dy53c1t0RzNDQcGX8wxS7YAxydL1S1hrMo41vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjwHhBVgEiFSosTIYZUtui1it6DbbhxZoSQISqV699M=;
 b=PqsE1YQsIqSMT2D+9DNY625R3yp6wphnbtQASNlmkryiTyzPEaOPnV9rp2yx07pVnvheL+FydlOiGEGCGe8NHzvk+LNMOEgf1WpdOUCvvTPSHvkr41SWlMtjfhPz2DDVECdSjXolYixT/3hheIKrd7d2NPbbz+3IDgKvuEV7xQQ=
Received: from LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:50:22 +0000
Received: from LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::f132:7e75:fd38:8685]) by LV5PR12MB9828.namprd12.prod.outlook.com
 ([fe80::f132:7e75:fd38:8685%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:50:22 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
Subject: RE: [PATCH v2] EDAC/versalnet: Refactor memory controller
 initialization and cleanup
Thread-Topic: [PATCH v2] EDAC/versalnet: Refactor memory controller
 initialization and cleanup
Thread-Index: AQHcTW7z1PYbNYRUSkWacGOBp48rm7TqiJUAgKtb9KA=
Date: Thu, 26 Feb 2026 16:50:22 +0000
Message-ID:
 <LV5PR12MB9828F14FA3E06001BB0878E78172A@LV5PR12MB9828.namprd12.prod.outlook.com>
References: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>
 <20251109155844.GUaRC6NHP2x4oO2Dk0@fat_crate.local>
In-Reply-To: <20251109155844.GUaRC6NHP2x4oO2Dk0@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-26T16:48:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR12MB9828:EE_|LV2PR12MB5991:EE_
x-ms-office365-filtering-correlation-id: ff914cbd-57bc-44dc-c389-08de755721f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 MMpL6Ykzp9pdKJo5Ps9ainQrOwShPNYhCucQPG4GHHTzffQAR08OczV4TNOtsx1IitRta6MFpaj8lM7nZlag5u/3Vd2VahiU8h7le3pE8yPdxjeYpcttK9thfuAtD4Wy2TjIlWbnZrrApXJ4/RECSiL2El7qmGK+c4V+i91byp0tktVWccZxJMAxnsdZnL+rEySZ+Lei7T3TnNvxI0EGXLxd5wHJT21T+18y12SGsojQSVyNopw7IK1UFwbJRHtyUqvoIgefklX1dCqS9JuJceZDQqUzpLRYPDfP9d521orjBVZIs30lJ70H98CLiPQj//Rg3YADS7ToD2fQb3zqrzJ+TR1tcXoDKYRmvE8xBhpAyJs+YGxN60nRDNg5m5kMEcMbKRvKX9aDewjIHoWkaD9fSpeYBSb6NHa4XRg6ekOhSo6OfyrZ8Mz/T63YTbd5Fh0RkqI/hBFrCJyvj0qXb6I5zRe3KqGylwhNRn0h/0DP9eY8n0gQmGshDYbPsdBUN/e0iv2xxNStUEY9Ygq+spAp4FmRLSGP34eDhaGTjo92znKrjlWAz+qgG2FdqBucLSRcClF7e6sxFHLEmDwIQmPH03nmZYagG5fOVYIXW7zbsghzGBRyuX2P19/6jVXG3uLsmnFFzPRkdwX0W4OXjJ9kdjlddMH1juhHa7ef7ir5oPqnhXA22islBWbrkBHGOvp58DXQi7cH9hJEbZ8eSI1BtzXmp0xvBqd8kywyQLmTShRlz9jYhbP1IAHkiWm6CPGxMCq3ZbvZ3wasU44s3HCd+F2ikSfD4tAhGGEnWW8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9828.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cldsT1RZL0wrQUJ6L0hlU1Zic3BRandiZ1Zrd1VVU24xTFFFYnljb0dpZ09k?=
 =?utf-8?B?cnlSUTZ1UDRUNTJZcG5BeldaSEFyeGdjVWlDVEFTOG9jMmgra1hxZndmeG1n?=
 =?utf-8?B?NTdhRENvQjlDTWc4Q1NkcklObnFuOXhkQ3A2ZzhXQWFGbzI2OWxxdy9zdU1o?=
 =?utf-8?B?a3NLSGtFb0ZBN3JFWEU4QzJYeW5aa1FPeVMvZDVNUTVjWndvdy8zU1REcitN?=
 =?utf-8?B?c1JGL0pyZStFR0NvY2wwY0hhanZDSks3dXdVL1IxMGZpTklmSUVZdUFkV0RX?=
 =?utf-8?B?YUpzQWFWRVdrazlVVVF5YXR4M3hKRGpSb0tXRVR3MFNkWGxSNENvKzZjY2xh?=
 =?utf-8?B?RWZWajN2dThmSVVOU0tWQ3RYMlNqRm5MZDc3ZHMrWTVHQk0wdUZwQ2tCWUFi?=
 =?utf-8?B?VEpvMzVBaXk4REFQVm5RK0V5QjNVS1NmQXBCMEpzbFZka3ZpOWh5SUpheUQv?=
 =?utf-8?B?Wm5jKy91ZlZ4QWNMamt5bWRCM0VVd2F1d0h6WGh6eE84M0RNUktQSXpQZC9K?=
 =?utf-8?B?R3ZhZVZsL05YaXFzb0tlRXVHd2s5NWNlUEFmWUZ0RkZpMEtIT0hlczY4NE02?=
 =?utf-8?B?SkMzd1IvNGUvMTFkRlN6VG9ueVRNWEF0NGxNNUN3VmkrL3lsL3k5Y3R1Qmtz?=
 =?utf-8?B?WGlId3Z5ZkFpNVg5RWRmTmhiekFsVjdTaXdpWHVodW11bk9iaThhV0dWNUhB?=
 =?utf-8?B?b3ZHd2RYTEw0ZUtRWURjeUM2UUJ4RlV1WUZHcnFZSm10MHNkeXI2Ung3K2Nv?=
 =?utf-8?B?bUJPYnkxYSt2azJaa1JRVVF0eEtRQm9BM3pOVEpybkpVYTk2ajBPc1FrNUc1?=
 =?utf-8?B?eUFKSnJzN3lsT2kxL3U2eFBCcnFySE9jRXZwckpvS2g1aVNySC90SFFhMGlO?=
 =?utf-8?B?VmdmU1FsVlloVUs4ZWREMDA4OWNBTmJ0MlVLaE9uU2lqU0pUdDJqQTMxV3Q1?=
 =?utf-8?B?T1M5WHZ2Wk9LMTdOWlRDd0doai9Ja0c5NFlkU0RrUXJ0ZVdhR0s2bGdWWHFK?=
 =?utf-8?B?Rko3SWJCNkdpbmppOCtuNlBBd2VHaWNjcXBCOUoxL1N6cFc0d3VXZ1Z3Vjg2?=
 =?utf-8?B?NVJlcTlUSmdndW1WMTVEc05WTzZWT3pTYkZYNldWNzA5Ujk3eTBpb0s2blhE?=
 =?utf-8?B?OTcyekh5aHlWektQVUpVdmg3WUZXbHpqOUlIWjdFZUdSa0k4akhUaGVUUE44?=
 =?utf-8?B?VEF3TFpsVUFtK01FY1I1d2FxbXlWRGJQS0xqQ0ZtdXFlVXNDSms2SlpKckpl?=
 =?utf-8?B?dndhS3BaTk84TWl2QUJtSWxsNXNVeHpaa0poUUN2U2I0LzVXU1VOMWZFY1Av?=
 =?utf-8?B?Tzh6VjljNTRDUDRRSmRPSmVEQnJGRVE4d1pmVGYxZmV5UmJYdHh3T3d0amNj?=
 =?utf-8?B?MHcxMGtEcHVxNnQ0Q2pNTFN2WmFuclVvQTdWQ1Vwb3pSTGliTTN6ZmdicEpq?=
 =?utf-8?B?UXNFK2ZKTEhSUG85QnZMQ3pqNkM0WXdqOTZCbXNEM0pZRzR4VmNEMDdESGFW?=
 =?utf-8?B?allVOUZqWGRQcjNTMTBjVXBYN251emNhRmdpNTBpUjUwcGRaV0xkcG5PeE43?=
 =?utf-8?B?cFRnU1R5MUhldE5ESUNXOUo1bTE3dTN4NkFXaUowWjZoZWhsdFM1ZUE0aHI2?=
 =?utf-8?B?Q0F2QlhUS1hFejNJUEpabTNiR2hlU3RqQXJlK0NpK29oaENzTmFWSVh6SFNa?=
 =?utf-8?B?dnpRUUsxRmRETVdHTEw3eG1vMHA3SHZlOFpBV3FueFhYT1FxbDVNcURvSlYx?=
 =?utf-8?B?SERYN1dYZmhSaThuVmpEYWpoTWQzbGRUaVAzOXJRQlVHelVIQjJaY1oyTkRu?=
 =?utf-8?B?Q2VwTVN3NHhpZHpzeWFxdE9WOFpnR1JRbmh1SWN5OWNUZ0ZZcFhWbThSazBF?=
 =?utf-8?B?SmFFb3FRVEZiYTNNMksyWXdoMHBGRXpnOWtsK0taeG9BQ2tySWtHZmVCaHdT?=
 =?utf-8?B?T2FRTFBKa2cyOFlDZ3B6ZXhHbFNTVENBcVBlTi9OckUxWXRwRG1aTVl5OFhZ?=
 =?utf-8?B?aTVEckxvdnMxYkpOazUzRC81TlNoWmVRM3A2RHFVR201NTdFTS85UFZzcWxS?=
 =?utf-8?B?V1FmUVF6TVd3OExrZE1wbXFmQ2JISjNXVTh3Zkp0SHFqQVNqRldkeThVOXVi?=
 =?utf-8?B?ZmlFNW5XTFRmak11N011eTc1L0NLTUlyOVMrbU1KTTMwcmxzZ0NXZS9DcktR?=
 =?utf-8?B?RWJkZUZqUGwvc201Sy90eVcxTmNCS3ZPVG5PQU9NU3ZZUWVuSDJPNCtsUDV0?=
 =?utf-8?B?TVBmcmdxSEpRZHZ2VGNURFAzdzFZbUR0U1l2UVQ4VVNQYzltRkVQS2lEdS9j?=
 =?utf-8?Q?616fc2jPpr0VkXZrTA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff914cbd-57bc-44dc-c389-08de755721f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 16:50:22.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoHbogA2+nnayAFesfcfp8q19eQva4ap0hqt3rb6A1VzD7unZUfanBgCMv4+OC2NOEiZ+c3+07kL0QYb+N53/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5752-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,arm.com,kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubhrajyoti.datta@amd.com,linux-edac@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:email,amd.com:email,amd.com:dkim,LV5PR12MB9828.namprd12.prod.outlook.com:mid,arm.com:email]
X-Rspamd-Queue-Id: B3EC41ACA1F
X-Rspamd-Action: no action

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogU3VuZGF5LCBOb3ZlbWJlciA5LCAyMDI1IDk6MjkgUE0N
Cj4gVG86IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPg0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5l
bC5vcmc7DQo+IHNodWJocmFqeW90aS5kYXR0YUBnbWFpbC5jb207IFRvbnkgTHVjayA8dG9ueS5s
dWNrQGludGVsLmNvbT47IEphbWVzIE1vcnNlDQo+IDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+Ow0KPiBSb2JlcnQgUmljaHRl
ciA8cnJpY0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBFREFDL3ZlcnNh
bG5ldDogUmVmYWN0b3IgbWVtb3J5IGNvbnRyb2xsZXINCj4gaW5pdGlhbGl6YXRpb24gYW5kIGNs
ZWFudXANCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRl
cm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVu
dHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUdWUsIE5vdiAw
NCwgMjAyNSBhdCAwMzowOToyMFBNICswNTMwLCBTaHViaHJhanlvdGkgRGF0dGEgd3JvdGU6DQo+
ID4gU2ltcGxpZnkgdGhlIGluaXRpYWxpemF0aW9uIGFuZCBjbGVhbnVwIGZsb3cgZm9yIFZlcnNh
bCBOZXQgRERSTUMNCj4gPiBjb250cm9sbGVycyBpbiB0aGUgRURBQyBkcml2ZXIuDQo+ID4NCj4g
PiBJbnRyb2R1Y2UgYGluaXRfc2luZ2xlX3ZlcnNhbG5ldCgpYCBmb3IgcGVyLWNvbnRyb2xsZXIg
c2V0dXAgYW5kDQo+ID4gICBgaW5pdF92ZXJzYWxuZXQoKWAgZm9yIGxvb3BpbmcgdGhyb3VnaCBO
VU1fQ09OVFJPTExFUlMsIGFsc28gYWRkDQo+ID4gcm9sbGJhY2sgbG9naWMgdG8gaGFuZGxlICBw
YXJ0aWFsIGluaXQgZmFpbHVyZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHViaHJhanlv
dGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4g
Q2hhbmdlcyBpbiB2MjoNCj4gPiAtIFJlbmFtZSBpbml0X3NpbmdsZV92ZXJzYWxuZXQoKSB0byBp
bml0X21jKCkgZm9yIGNsYXJpdHkuDQo+ID4gLSBSZW5hbWUgcmVtb3ZlX3NpbmdsZV92ZXJzYWxu
ZXQoKSB0byByZW1vdmVfbWMoKSB0byBtYXRjaCBuYW1pbmcNCj4gY29udmVudGlvbi4NCj4gPiAt
IFNpbXBsaWZ5IGVycm9yIGhhbmRsaW5nIGluIGluaXRfdmVyc2FsbmV0KCkgYnkgcmVwbGFjaW5n
IGdvdG8gd2l0aCBhIHJvbGxiYWNrDQo+IGxvb3AuDQo+ID4gLSBSZWR1Y2UgaW5kZW50YXRpb24g
YW5kIGNvbnNvbGlkYXRlIGNsZWFudXAgbG9naWMuDQo+DQo+IEJldHRlciwgaGVyZSdzIHNvbWUg
bW9yZSBpbXByb3ZlbWVudHMgYW5kIGNsZWFudXBzIG9udG9wLiBZb3UgcHJvYmFibHkNCj4gc2hv
dWxkIGFwcGx5IHRoZSBkaWZmIHRvIGJldHRlciBzZWUgd2hhdCBJIG1lYW46DQo+DQo+IC0gZG8g
dGhlIGt6YWxsb2MgYWxsb2NhdGlvbnMgZmlyc3QNCj4gLSBwdWJsaXNoIHRoZSBzdHJ1Y3R1cmVz
IG9ubHkgYWZ0ZXIgdGhleSd2ZSBiZWVuIGluaXRpYWxpemVkIHByb3Blcmx5IHNvIHRoYXQNCj4g
ICB5b3UgZG9uJ3QgbmVlZCB0byB1bndpbmQgdW5uZWNlc3NhcmlseSB3aGVuIGl0IGZhaWxzIGxh
dGVyDQo+IC0gcmVtb3ZlX3ZlcnNhbG5ldCgpIGlzIG5vdyB0cml2aWFsDQo+DQo+IERvIHJ1biBp
dCBvbiB0aGUgaHcgYW5kIGhhdmUgdGhlIGNvZGUgZmFpbCBhdCBjZXJ0YWluIHBsYWNlcyBvbiBw
dXJwb3NlIHRvIG1ha2UNCj4gc3VyZSB0aGUgdW53aW5kaW5nIGhhcHBlbnMgcHJvcGVybHkuDQoN
ClRlc3RlZCBvbiB0aGUgaGFyZHdhcmUuDQoNCj4NCj4gSFRILg0KPg0KPiAtLS0NCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy92ZXJzYWxuZXRfZWRhYy5jIGIvZHJpdmVycy9lZGFjL3Zl
cnNhbG5ldF9lZGFjLmMgaW5kZXgNCj4gMDFlZGM3NDA4YTVjLi5kYzYxMDhmN2NlZTMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy92ZXJzYWxuZXRfZWRhYy5jDQo+ICsrKyBiL2RyaXZlcnMv
ZWRhYy92ZXJzYWxuZXRfZWRhYy5jDQo+IEBAIC03MCw2ICs3MCw4IEBADQo+ICAjZGVmaW5lIFhE
RFI1X0JVU19XSURUSF8zMiAgICAgICAgICAgICAxDQo+ICAjZGVmaW5lIFhERFI1X0JVU19XSURU
SF8xNiAgICAgICAgICAgICAyDQo+DQo+ICsjZGVmaW5lIE1DX05BTUVfTEVOICAgICAgICAgICAg
ICAgICAgICAzMg0KPiArDQo+ICAvKioNCj4gICAqIHN0cnVjdCBlY2NfZXJyb3JfaW5mbyAtIEVD
QyBlcnJvciBsb2cgaW5mb3JtYXRpb24uDQo+ICAgKiBAYnVyc3Rwb3M6ICAgICAgICAgIEJ1cnN0
IHBvc2l0aW9uLg0KPiBAQCAtNzU4LDcgKzc2MCw3IEBAIHN0YXRpYyB2b2lkIHZlcnNhbF9lZGFj
X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgICAgICAgIGtmcmVlKGRldik7DQo+ICB9
DQo+DQo+IC1zdGF0aWMgdm9pZCByZW1vdmVfbWMoc3RydWN0IG1jX3ByaXYgKnByaXYsIGludCBp
KQ0KPiArc3RhdGljIHZvaWQgcmVtb3ZlX29uZV9tYyhzdHJ1Y3QgbWNfcHJpdiAqcHJpdiwgaW50
IGkpDQo+ICB7DQo+ICAgICAgICAgc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpOw0KPg0KPiBAQCAt
NzY4LDcgKzc3MCw3IEBAIHN0YXRpYyB2b2lkIHJlbW92ZV9tYyhzdHJ1Y3QgbWNfcHJpdiAqcHJp
diwgaW50IGkpDQo+ICAgICAgICAgZWRhY19tY19mcmVlKG1jaSk7DQo+ICB9DQo+DQo+IC1zdGF0
aWMgaW50IGluaXRfbWMoc3RydWN0IG1jX3ByaXYgKnByaXYsIHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsIGludCBpKQ0KPiArc3RhdGljIGludCBpbml0X29uZV9tYyhzdHJ1Y3QgbWNfcHJp
diAqcHJpdiwgc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiArKnBkZXYsIGludCBpKQ0KPiAgew0K
PiAgICAgICAgIHUzMiBudW1fY2hhbnMsIHJhbmssIGR3aWR0aCwgY29uZmlnOw0KPiAgICAgICAg
IHN0cnVjdCBlZGFjX21jX2xheWVyIGxheWVyc1syXTsNCj4gQEAgLTgwOSw0MSArODExLDU0IEBA
IHN0YXRpYyBpbnQgaW5pdF9tYyhzdHJ1Y3QgbWNfcHJpdiAqcHJpdiwgc3RydWN0DQo+IHBsYXRm
b3JtX2RldmljZSAqcGRldiwgaW50IGkpDQo+ICAgICAgICAgbGF5ZXJzWzFdLmlzX3ZpcnRfY3Ny
b3cgPSBmYWxzZTsNCj4NCj4gICAgICAgICByYyA9IC1FTk9NRU07DQo+IC0gICAgICAgbWNpID0g
ZWRhY19tY19hbGxvYyhpLCBBUlJBWV9TSVpFKGxheWVycyksIGxheWVycywNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QgbWNfcHJpdikpOw0KPiAtICAgICAgIGlm
ICghbWNpKSB7DQo+IC0gICAgICAgICAgICAgICBlZGFjX3ByaW50ayhLRVJOX0VSUiwgRURBQ19N
QywgIkZhaWxlZCBtZW1vcnkgYWxsb2NhdGlvbiBmb3INCj4gTUMlZFxuIiwgaSk7DQo+ICsgICAg
ICAgbmFtZSA9IGt6YWxsb2MoTUNfTkFNRV9MRU4sIEdGUF9LRVJORUwpOw0KPiArICAgICAgIGlm
ICghbmFtZSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiByYzsNCj4gLSAgICAgICB9DQo+IC0g
ICAgICAgcHJpdi0+bWNpW2ldID0gbWNpOw0KPiAtICAgICAgIHByaXYtPmR3aWR0aCA9IGR0Ow0K
Pg0KPiAgICAgICAgIGRldiA9IGt6YWxsb2Moc2l6ZW9mKCpkZXYpLCBHRlBfS0VSTkVMKTsNCj4g
ICAgICAgICBpZiAoIWRldikNCj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyX21jX2ZyZWU7DQo+
IC0gICAgICAgZGV2LT5yZWxlYXNlID0gdmVyc2FsX2VkYWNfcmVsZWFzZTsNCj4gLSAgICAgICBu
YW1lID0ga21hbGxvYygzMiwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVy
cl9uYW1lX2ZyZWU7DQo+ICsNCj4gKyAgICAgICBtY2kgPSBlZGFjX21jX2FsbG9jKGksIEFSUkFZ
X1NJWkUobGF5ZXJzKSwgbGF5ZXJzLCBzaXplb2Yoc3RydWN0IG1jX3ByaXYpKTsNCj4gKyAgICAg
ICBpZiAoIW1jaSkgew0KPiArICAgICAgICAgICAgICAgZWRhY19wcmludGsoS0VSTl9FUlIsIEVE
QUNfTUMsICJGYWlsZWQgbWVtb3J5IGFsbG9jYXRpb24gZm9yDQo+IE1DJWRcbiIsIGkpOw0KPiAr
ICAgICAgICAgICAgICAgZ290byBlcnJfZGV2X2ZyZWU7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAg
ICAgICAgc3ByaW50ZihuYW1lLCAidmVyc2FsLW5ldC1kZHJtYzUtZWRhYy0lZCIsIGkpOw0KPiAr
DQo+ICAgICAgICAgZGV2LT5pbml0X25hbWUgPSBuYW1lOw0KPiArICAgICAgIGRldi0+cmVsZWFz
ZSA9IHZlcnNhbF9lZGFjX3JlbGVhc2U7DQo+ICsNCj4gICAgICAgICByYyA9IGRldmljZV9yZWdp
c3RlcihkZXYpOw0KPiAgICAgICAgIGlmIChyYykNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJy
X21jX2ZyZWU7DQo+DQo+ICAgICAgICAgbWNpLT5wZGV2ID0gZGV2Ow0KPiAtDQo+IC0gICAgICAg
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+IC0NCj4gICAgICAgICBtY19pbml0
KG1jaSwgZGV2KTsNCj4gKw0KPiAgICAgICAgIHJjID0gZWRhY19tY19hZGRfbWMobWNpKTsNCj4g
ICAgICAgICBpZiAocmMpIHsNCj4gICAgICAgICAgICAgICAgIGVkYWNfcHJpbnRrKEtFUk5fRVJS
LCBFREFDX01DLCAiRmFpbGVkIHRvIHJlZ2lzdGVyIE1DJWQgd2l0aCBFREFDDQo+IGNvcmVcbiIs
IGkpOw0KPiAgICAgICAgICAgICAgICAgZ290byBlcnJfdW5yZWc7DQo+ICAgICAgICAgfQ0KPiAr
DQo+ICsgICAgICAgcHJpdi0+bWNpW2ldID0gbWNpOw0KPiArICAgICAgIHByaXYtPmR3aWR0aCA9
IGR0Ow0KPiArDQo+ICsgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+
ICsNCj4gICAgICAgICByZXR1cm4gMDsNCj4gKw0KPiAgZXJyX3VucmVnOg0KPiAgICAgICAgIGRl
dmljZV91bnJlZ2lzdGVyKG1jaS0+cGRldik7DQo+ICBlcnJfbWNfZnJlZToNCj4gICAgICAgICBl
ZGFjX21jX2ZyZWUobWNpKTsNCj4gK2Vycl9kZXZfZnJlZToNCj4gKyAgICAgICBrZnJlZShkZXYp
Ow0KPiArZXJyX25hbWVfZnJlZToNCj4gKyAgICAgICBrZnJlZShuYW1lKTsNCj4gKw0KPiAgICAg
ICAgIHJldHVybiByYzsNCj4gIH0NCj4NCj4gQEAgLTg1MiwxMCArODY3LDEwIEBAIHN0YXRpYyBp
bnQgaW5pdF92ZXJzYWxuZXQoc3RydWN0IG1jX3ByaXYgKnByaXYsIHN0cnVjdA0KPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgaW50IHJjLCBpOw0KPg0KPiAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBOVU1fQ09OVFJPTExFUlM7IGkrKykgew0KPiAtICAgICAgICAgICAgICAgcmMg
PSBpbml0X21jKHByaXYsIHBkZXYsIGkpOw0KPiArICAgICAgICAgICAgICAgcmMgPSBpbml0X29u
ZV9tYyhwcml2LCBwZGV2LCBpKTsNCj4gICAgICAgICAgICAgICAgIGlmIChyYykgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICB3aGlsZSAoaS0tKQ0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlbW92ZV9tYyhwcml2LCBpKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZW1vdmVfb25lX21jKHByaXYsIGkpOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmM7DQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiBAQCAtODY0
LDE0ICs4NzksOCBAQCBzdGF0aWMgaW50IGluaXRfdmVyc2FsbmV0KHN0cnVjdCBtY19wcml2ICpw
cml2LCBzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPg0KPiAgc3RhdGljIHZvaWQg
cmVtb3ZlX3ZlcnNhbG5ldChzdHJ1Y3QgbWNfcHJpdiAqcHJpdikgIHsNCj4gLSAgICAgICBzdHJ1
Y3QgbWVtX2N0bF9pbmZvICptY2k7DQo+IC0gICAgICAgaW50IGk7DQo+IC0NCj4gLSAgICAgICBm
b3IgKGkgPSAwOyBpIDwgTlVNX0NPTlRST0xMRVJTOyBpKyspIHsNCj4gLSAgICAgICAgICAgICAg
IGRldmljZV91bnJlZ2lzdGVyKHByaXYtPm1jaVtpXS0+cGRldik7DQo+IC0gICAgICAgICAgICAg
ICBtY2kgPSBlZGFjX21jX2RlbF9tYyhwcml2LT5tY2lbaV0tPnBkZXYpOw0KPiAtICAgICAgICAg
ICAgICAgZWRhY19tY19mcmVlKG1jaSk7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIGZvciAoaW50
IGkgPSAwOyBpIDwgTlVNX0NPTlRST0xMRVJTOyBpKyspDQo+ICsgICAgICAgICAgICAgICByZW1v
dmVfb25lX21jKHByaXYsIGkpOw0KPiAgfQ0KPg0KPiAgc3RhdGljIGludCBtY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91
dC1uZXRpcXVldHRlDQo=

