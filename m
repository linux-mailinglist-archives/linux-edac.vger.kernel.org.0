Return-Path: <linux-edac+bounces-4138-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEF8AD8743
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F143A365F
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9367279DB2;
	Fri, 13 Jun 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="hnOjAQxC"
X-Original-To: linux-edac@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022101.outbound.protection.outlook.com [52.101.126.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C75256C73
	for <linux-edac@vger.kernel.org>; Fri, 13 Jun 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805818; cv=fail; b=Y8vdcES3L5wiOj6qd+E0X+IQ5vuJZmBGoqjv+rtUNyBJCQQkTMoDAlaFBuedHzQQVKW024VCAqzwGDhZBhwYpMPGsLMYc7p0bIzV4s2xhT3xaMSLp5JYxDmDBmYzlCe2wd3AqM8DGHPCTYNZZNXXlJqOxd6DrVzgQCfK6BTMLZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805818; c=relaxed/simple;
	bh=6FCrfgS2jhvVYxkkFog8vfrdCxsKJc7fPlu6Dv9EpDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MZODq+v0ATZMedLITydZy1aXKzfwWh1awcneApfzPyiNvG1aKe1Q6kOH+TnrfeI90gBCQ9UOB31JajBS1g8cgNogz5jG+pGeWfiDZfF4n4rRQvyw4Wu1GmXC/+wM1t+f+42seTl2fXf6k2wJqQnOXYR4PZ04SadtjohjY3gztFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=hnOjAQxC; arc=fail smtp.client-ip=52.101.126.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxAZ+xMHR5jP/WvtoDF2xthuoQl4KNpVU2PFEBdiujdXRZ+68rwsT255ToZ0MZMFdACgeM0FTSnZ/pfvBBpBROZD5imY67Yn+bUN2xR8RQyld9vhK1oOI/hv1kJsOR10OyTRuVPWm6Ox8F+EPLsvhR2PM2YlhAhK4Mg+doCZ1oIdXxYq8PNvcInvyFt0NUJxT7TyTc088G1+Pf1mrILDMdVWfzWBhaGXDPtx19/zkt63cxQPU4fsLyCeP+O2x9If+jaP/hx1haWQzYioXjBwYQ43c7wWrELpMkptg/+72elPTNletKukqOzCzsjrx3pAndyfkG1ymGWa1OV8zLRYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FCrfgS2jhvVYxkkFog8vfrdCxsKJc7fPlu6Dv9EpDE=;
 b=nPiPzwbtKwvvcz29wpV+5wIjO8Wm5+jYa+C/Y8FREtUSHHI6oaC3/cI5gsPZ4dJIPzTdpfY+0HKt23svKaPyVHMRe0qHkQjAK1rxxU6qBnboXkgfoIq4GzpurxwhaeEs6FONO0+sbMJvJyyZ8XnUpM3CTzqZ0Qv387euOzlaoBV/E8dyNk61YWsNw2HL2RRepGtU45fMRBhrO5C7PqH2AbPWLb5kGhvCYdJ8akwaDQW9uofvriTc/Han1lhqOQvntwupzJpNdxoNGVH+vR+WdkxXhn0Ebm0fCTDnt+gS4bCW7bc4gHZn9edb3R/kwbVlu9GnwBphG0xTbqjui9GLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FCrfgS2jhvVYxkkFog8vfrdCxsKJc7fPlu6Dv9EpDE=;
 b=hnOjAQxCbK0O+RIJnyNTP9wQtIKlNq1p16mnDm0HpFqQkbsKmFWVBUV5SRlD4BYS/2XKjRbXP0UVbTxXMMVwgI9dXcw43Q+fMUaTQEg/17vrSeexumz3Z4n4I0dnMf+GfNtOYNe+R2VyWhbq8SM7MoLXOHQp9XosN4vTDWSo+RcK/KF/huaBbRsU0bQdeHZrXUVxv3YnHJOZfImR6/0O7NtCJVEywFZcQxXg6dhI1wVQ0iUEJpQLzAgkGVbmahHe35llqRveitcA9Cv2UzFYSeW+VBWrWKLkq3yM4r0ZfWELCgs8NDjn8vqKD73ySReC5qjVl0Cpmjph/SoIxW9M9g==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TY0PR06MB5732.apcprd06.prod.outlook.com
 (2603:1096:400:270::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 09:10:08 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%6]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 09:10:07 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: "Luck, Tony" <tony.luck@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
CC: Angus Chen <angus.chen@jaguarmicro.com>, Hunter He
	<hunter.he@jaguarmicro.com>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIG1jZS10ZXN0XSByYW5kb21fb2ZmbGluZTogRml4ICdz?=
 =?gb2312?Q?yntax_error'_test_failure_on_AArch64?=
Thread-Topic: [PATCH mce-test] random_offline: Fix 'syntax error' test failure
 on AArch64
Thread-Index: AQHbzwfF89iM7bwHzk6ZMZetB9r6ArPnAWeAgAB61+A=
Date: Fri, 13 Jun 2025 09:10:06 +0000
Message-ID:
 <KL1PR0601MB5773C4983FF8637550F18BD3E677A@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20250527130228.315-1-rex.nie@jaguarmicro.com>
 <SJ1PR11MB6083AEEFDFB56242726DB758FC64A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ1PR11MB6083AEEFDFB56242726DB758FC64A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|TY0PR06MB5732:EE_
x-ms-office365-filtering-correlation-id: 4a20e618-4664-471b-521d-08ddaa5a1733
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Vi9zVVFYdW1zMUloNzNSSlJ0YkhjVG5KbFJlTWd5M1BJSUdGbkRGYWpIZ0FF?=
 =?gb2312?B?VUVhSjdBWkI0bnkya2Ewc0VCcWJSUW9jbmp6U2F1Q3FlSXE4MkxScTFPNWxH?=
 =?gb2312?B?ai95WGd6RFRMNHRrVWYrVldDb2ZxbFozQlBEQ3BWMzBlOU1LZ0xPbnVEamhp?=
 =?gb2312?B?Rk11eUdJeDBQbGxaT3h3T0NQakJpYjRuV1NnQkVsUU9EOXNqaWo5SlhzRnZu?=
 =?gb2312?B?SWxUTFZHVVVqSE4vTkg5T1h6T0VhMzBqc1p1Qld1WFgrYk1ubDZ4YTFFd3dV?=
 =?gb2312?B?aWF0d3FwcmFtblNwUEJNUTNYMElkTUtIcjd3U0d0L3RmbHdzWlZGVXBKZnN1?=
 =?gb2312?B?UTFuSDhzSmszV2JwOGd2V0lQdFA4V2xiclU0Nk9ySlVrZkx4clZRWDNHYWs3?=
 =?gb2312?B?TWFzcHNCM2xpOWZkb0VibmtUNkkwMHRpZjhkRE0zVi9OZE5RMXMzdlZ6RElQ?=
 =?gb2312?B?dUplZE92SXA0Q2Q2YzZRcC9jbHhDQ2xXeWlyTVo1YTdIOHdBU3M3QjBrMW12?=
 =?gb2312?B?QUpIWkl2N3o4bmlwZC9EWm9MT3RYWlRaSXJDOGZXeUUvUGRtV0trcjliZ2Fi?=
 =?gb2312?B?Y0tNNWErbmtXMlJWVFBmV3ZLWWRMcCtOQnBhb3dFOWRGUFFDY3QzeEllOGpS?=
 =?gb2312?B?Y01WSFk3eXZDY2ZuYlJpQU85a0J6ckJmVjlMcmI0cVJXajNoN0VaZmtBZ0RX?=
 =?gb2312?B?QVN1VVhhaDU1K21WM2pLSU5HQS82T3B6TlJKNVNMejF5bjhQMHR1NkhudGRz?=
 =?gb2312?B?Z2g5TlJEVFZkZE1oWDFQaGM4TDlkMTUreVlpTTJQMFIwKzZuajFnZ2lBYUhr?=
 =?gb2312?B?SEZyV01MTFZxSUtFNE5INmU5MHJoOEJoN24yU3NVa3d5K25CN05WUGxJMTgx?=
 =?gb2312?B?d3dEbDBIUWFKR0JybWZBL1QyUW1JdW56NWFzQUIzN28xMUJaZHZ6djQzZ1dF?=
 =?gb2312?B?azl3c1VLTGJLNWtrRXlUUlduTFF6YU56SkJreXhpamxRNngzS2tidFVESkhh?=
 =?gb2312?B?aXJUbU5pcEdSNnBLczlwbmxvTFEwaTN4UUg2OWZlaWM3VDZxKzY5TlJIUVl2?=
 =?gb2312?B?ZXZZWFhsZEgyOERPYVZpbk5RbW1YQkFFSGRjcEFuSGt3dUVqRWo0K0lLVkZ3?=
 =?gb2312?B?Um5xQnBlVmhocHR1L09EYWxIRTY3K0dlS1RaQkZ5b3F6S1lUUGJrZDZpSW5K?=
 =?gb2312?B?SXFmK1l2UnFockhmT3Rma28rYWlZWldqZVFPYVJ1LzQzMTk2UHR6R3JWd2Fa?=
 =?gb2312?B?ajQyNkJFc25aemI0MnBxY1NHU3RVOEdabDBtbi9ibkZGNXVacWwrblVveDZU?=
 =?gb2312?B?N2liWjFqWC9PSU5sc0ZwYVBrVFd6SmJkZ25PaGRRNVpjamoybnBHVzJqYUhw?=
 =?gb2312?B?cFVaTkNCbzA5cC93cDBSZGx3SWoydFRkMDZ3S3hwQmRPM0ExeXUyd1dHNDlp?=
 =?gb2312?B?ZTBLMis4dXFuNCtvUjZFUHJhVGpNdER1YndkbUlrUVd3SCsrSXFydnUxclhJ?=
 =?gb2312?B?SWF4T0RjSmJ1UHFyZ3lzVDhXc2RSOGxudHlXRTZjVGpIZjRKNDZzZFVRcks3?=
 =?gb2312?B?SnVkbzJoYzB4czZBQnhDbCt4Q2RZelVKWWc5MUkza0NrcUpOc0o0cjV1V2V2?=
 =?gb2312?B?ZURLMWdhQkhjcjY1VGNTT0NUOEZ0US9SV3BtZUNGNm5GTE5aU01PclFsMkx4?=
 =?gb2312?B?clZRLzdtQzFzSzBySkFIU2hiVXBJTk96R0NIemRjN3Vmc1c2T1ExMHlzQjFJ?=
 =?gb2312?B?TEJFbGtFYzYyNjBJZ1FkUTAvK2x2RjdxSlE1RUdoUUpDaVVmWDVwYjFPejR0?=
 =?gb2312?B?WXEwREZ0MXJLMWxFVlVJSkZ4WjZwMTljME9YUFJtTmFrdDBoUzZQQW9GNkVP?=
 =?gb2312?B?dlVxRTJSZFBLN2M5bEZKMjVZbU9kQnJRTjhxUWxjN0g0Ym9MQVpQTnBidUFW?=
 =?gb2312?B?ZkV5V1VmYnVhK1BTaWp3N3haVGE4RFpYKytkVndYckZRUGdWRjhITkJCYXJ5?=
 =?gb2312?Q?pnz/xPD25ks9B2QebkDXnlBjyvjAIA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Sm43T3RwTjJIeFQ5cDY5TG9OSUhFQ1hrYjNaQ0JJWFVzenRFYTY0K0RNZ1lI?=
 =?gb2312?B?bVdneU80TzlWSFA1ZXU3UXV0aVpUUUJnRldRcmxKQWtLUW1mTHJ5MzMrWGxz?=
 =?gb2312?B?aVlCK1pvbEZBMVBPdUliUTE1bFV1TnF3Q1FqRDRieU42cC91S2liUUdaaE1w?=
 =?gb2312?B?RGxrUHdXNCtjMVpQL1VPWmo2bERHOUxwNlZJNGtMdXczK0ZKL21pNVZRWElE?=
 =?gb2312?B?a0xSTFlyZzZHV3U1L3QvdkxwWGh3KzNZVnBHL2pBWTRQME4zV0hCTkhYK09l?=
 =?gb2312?B?eHB4WkpvWjc2emxSTGRsZjJlWmszanBod0dHT3pTOWpYdjI5Z0krejExblU5?=
 =?gb2312?B?bWovOVZ0YzRBbkRPZitSZ3dLWmU3UFkwNkhKbDJOK0Y4VldOVEJmbElidnJr?=
 =?gb2312?B?eUJpSW45Yjl3ZUZnbnMrbU1FY2hKRmVGQjA4ckNpc1JkZGRnQlJ5RDQ3eVRG?=
 =?gb2312?B?OXQ1MW1lS3ZCaFZ6Qm1Pc2hScXA3eEFLYVdyVkdXUlRHTU1OTnpCNDAxazJh?=
 =?gb2312?B?TllGOWRyTE5GT3FwQStaMHIyRHVsaHJOZUxVSk5RbkcyOXBhVXZIV2t3em1j?=
 =?gb2312?B?SXdHSjFxQ3dzZTFsZFNER0RvV1ZPN1g2dGsxZEdNd283T05CTDFUdkhPeDFS?=
 =?gb2312?B?dDFlT3UvQ1lSc0NYcjNkcWs0akJuMkdMZERmNitJYVBUU0RpdkRtS09nNTln?=
 =?gb2312?B?aXhCelJDU09KZGczdzVUMWFFQk0zdGdyd3A5aDZnRXg1OG1TOExXUDE2TVJv?=
 =?gb2312?B?UnBkdml6L3lWaXFVZHVZRUFYNDZDVTltTitaMzgxMG1VNW1QVVYvaFpMYjBK?=
 =?gb2312?B?dFNtbitlUVVRM1R3b2hDYmphOWdWdVVpamkrQ1Bod0lLWTI2R1FnU2dLOTEr?=
 =?gb2312?B?M0paNGVDSXVuMldLTVBhUlN4U2ttRC84VHFQZ0VoOGMyVE5UWW1Rd0VleTdk?=
 =?gb2312?B?eWxPMmRtVTY5UkhZVzExSC9semoyMTF6RlhKVXBsaHEvNlVOU1BnVmpiZDhP?=
 =?gb2312?B?NUZDajdHb3Y1L25leWJBbHV3VjJPcnIrMnQ3TjJxekI2WnY0ZUluOURWOU9y?=
 =?gb2312?B?UTVKOWRVSTB6UytlS0NOSWhrcmdHL1E1bzZYNUVjMzhaaGhackRVUFhWaEs2?=
 =?gb2312?B?ZWQ3SmdrZ2x5cTZyWncwaUhIL0xGdnVoeWJrbDZuUUhEMHpYSzQra2E3S1oz?=
 =?gb2312?B?TlM0cHRxeXlZYnllbXFxdFRsMjIvR0ZWaVFXYWZCZmhYQ1hYRHZwVlhabnpk?=
 =?gb2312?B?UVpucEd1Zlpza3ZpTzVkdHN6TWg0N3R6MWtEYVgrUTdsMThGTDVKWTZCS3Nl?=
 =?gb2312?B?RjdmVnNranl1NjFlVTRZNThOSUxiOUpKZTFPdjhmSTRCKzNNZFk5WnRhU3NS?=
 =?gb2312?B?RlI4dEpndDdnTFF0WUhzcTc1RkphbVcvbEh4OUxVdkwwZWVMSnNadWh3Ykcy?=
 =?gb2312?B?V2x1aW4zZ1RVVFk3VUwxNytHNDExMTRFUFNxWG40U3hQa0p0K05oNWp4NEkr?=
 =?gb2312?B?Ky9OczBJR05PVTBzSkpYYnlSREVFaHlHL01GOTNIWWFFeVRINEdzWmRyb2pI?=
 =?gb2312?B?TGRiSmN3NTAzM1ZDV1VDa2E3b3E1WVh6SEtFbkR3ckhSQStIWXpLcGtVWTRl?=
 =?gb2312?B?RkxwU3FDRDF3bWhESjZ2Q1hYTnFrUWhObC9TTm13SkVVQ2dBbWxUclZRQ3Vo?=
 =?gb2312?B?QS9OVDV6bTJDM21BZjZQWTVFTXhacVpWVCtKRUNNMkFTM3hJV09VMmMrTUh4?=
 =?gb2312?B?WGszTFR1UDhndGxmWlExUzlxR0tuQ1BYcitqK0w4ZnYyWDZJdUVCSEJrVEdI?=
 =?gb2312?B?RVJ6bTJTRFZXVlY5WG03RVg5NGtUM1Z6QVEvRTNSSG9uM3JKa01hZW9XeGNP?=
 =?gb2312?B?WjN2K05HbmY0a043RWljVlpka205MUsxczRIOGt0V05BLy84eXR2QzF2RUNv?=
 =?gb2312?B?QmpLeE5Tb2ZLd21hR1VJRGw1ZGIxdTc4TE54WGFDMGJlWWRTdkZ5d2llT2Zh?=
 =?gb2312?B?V3RUbFJCQ096eGtKSlgzRk5yK2FiNDhmUWFteDFhd1l4Q1I0ai9HZ0hIbm5n?=
 =?gb2312?B?a0ZXaVpTV0xpdjk1b2ErK01kYzA2b2ZzWXE4QitNMm1hWEc3anV0KzVkMU1L?=
 =?gb2312?Q?uB7+tXntC3zcFUFfurzETrTMF?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a20e618-4664-471b-521d-08ddaa5a1733
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 09:10:06.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIUp/sQcvYvNemuVWjCNa6nQMeH8kfsZr0xYYW5JHgfjjIHG9b6oQqvFf4cU/I4MZ5sJmJnPveqE0jeTCQlzew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5732

SEkgVG9ueSwNCglUaGFua3MgZm9yIHlvdXIgY29tbWVudCwgSSB3aWxsIGFwcGx5IHYyIGFzIHlv
dSBhZHZpY2UuDQpCUnMNClJleA0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IEx1
Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+ILeiy83KsbzkOiAyMDI1xOo11MIyOMjV
IDU6MzkNCj4gytW8/sjLOiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT47IGxpbnV4
LWVkYWNAdmdlci5rZXJuZWwub3JnOw0KPiBha0BsaW51eC5pbnRlbC5jb20NCj4gs63LzTogQW5n
dXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+OyBIdW50ZXIgSGUNCj4gPGh1bnRl
ci5oZUBqYWd1YXJtaWNyby5jb20+DQo+INb3zOI6IFJFOiBbUEFUQ0ggbWNlLXRlc3RdIHJhbmRv
bV9vZmZsaW5lOiBGaXggJ3N5bnRheCBlcnJvcicgdGVzdCBmYWlsdXJlIG9uDQo+IEFBcmNoNjQN
Cj4gDQo+IEV4dGVybmFsIE1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIE9VVFNJREUg
b2YgdGhlIG9yZ2FuaXphdGlvbiENCj4gRG8gbm90IGNsaWNrIGxpbmtzLCBvcGVuIGF0dGFjaG1l
bnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uIHVubGVzcyB5b3UNCj4gcmVjb2duaXplIHRo
ZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiA+IEU9JChl
bmRfb2ZfbWVtb3J5KQ0KPiA+DQo+ID4gKyMgVGhlcmUgaXMgbm8gL3N5cy9maXJtd2FyZS9tZW1t
YXAvIGZvciBhcm0gcGxhdGZvcm0sIHNvIEUgd2lsbCBiZQ0KPiA+ICtlbXB0eSAjIElmIEUgaXMg
ZW1wdHksIHRyeSB0byBnZXQgZW5kIG9mIG1lbW9yeSBmcm9tIC9wcm9jL2lvbWVtIGlmIFsNCj4g
PiArLXogIiRFIiBdICYmIFsgLWYgIi9wcm9jL2lvbWVtIiBdOyB0aGVuDQo+ID4gKyAgICAgaz0k
KGdyZXAgIlN5c3RlbSBSQU0iIC9wcm9jL2lvbWVtIHwgdGFpbCAtbjEgfCBhd2sgLUYgJ1stIF0n
DQo+ID4gKyd7cHJpbnQgJDJ9JykNCj4gPiArDQo+ID4gKyAgICAgaz0ke2svMHgvfQ0KPiA+ICsg
ICAgIGs9JChlY2hvICRrIHwgdHIgYS16IEEtWikNCj4gPiArICAgICBFPSQoZWNobyAiaWJhc2U9
MTY7ICRrLzEwMDAiIHwgYmMpIGZpDQo+ID4gKw0KPiA+ICBlY2hvICJzb2Z0IG9mZmxpbmluZyBw
YWdlcyB1cHRvICRFIg0KPiANCj4gSSB0aGluayB0aGlzIHdvdWxkIGxvb2sgY2xlYW5lciBpZiB0
aGUgZml4IHdhcyBpbiB0aGUgImVuZF9vZl9tZW1vcnkiDQo+IGZ1bmN0aW9uLg0KPiANCj4gU29t
ZXRoaW5nIGxpa2U6DQo+IA0KPiBlbmRfb2ZfbWVtb3J5KCkNCj4gew0KPiAgICAgICAgIGlmIFsg
LWQgL3N5cy9maXJtd2FyZS9tZW1tYXAvIF0NCj4gICAgICAgICB0aGVuDQo+ICAgICAgICAgICAg
ICAgICAuLi4gZXhpc3RpbmcgY29kZQ0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAg
ICMgRmFsbCBiYWNrIHRvIC9wcm9jL2lvbWVtDQo+IA0KPiAgICAgICAgICAgICAgICAgLi4uIHlv
dXIgY29kZSBoZXJlDQo+ICAgICAgICAgZmkNCj4gfQ0KPiANCj4gLVRvbnkNCg==

