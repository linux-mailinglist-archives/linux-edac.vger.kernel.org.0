Return-Path: <linux-edac+bounces-5749-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEttJkjun2nYewQAu9opvQ
	(envelope-from <linux-edac+bounces-5749-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 07:55:04 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B871A1786
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 07:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDBD330557FB
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6B38BF6C;
	Thu, 26 Feb 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBvfuC8d"
X-Original-To: linux-edac@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A717A2EA;
	Thu, 26 Feb 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088859; cv=fail; b=qKupHv5/y/dzUuLfM6YhJWvpGTR9cmZloLIHdqZlQ+tjkFjrj/peoieO1B4bhR63N1dEnG+kCIh3yaVZDPXUol5sjJdsjbYJSXLSw7KJYGOdSh3bo6dXyhcxWhKPOQn0hUJd5hyirHkhrGGKgatZ+MfXwQrrfixNVDIuC6tCZ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088859; c=relaxed/simple;
	bh=wAp415GCCvZCDJr35rA1xCvBSXbS4RtA8vzZSdUa02c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/gYwo/IpUJtVv13LJNAB8W1sHm8y8dYaaqLL1nZR8SCaKJ6Vh+Yq/bggIECmdKxKL35vq2BZg/kBCnrK4V4Xph4FqhKtCpHxeWpB1R3jAHQdeDlQhQQznT7lnoM1rpMWH2c9dCiyw+3El0No1lHAf5De4fZlFOzjflyditn/b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBvfuC8d; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzfgSXu3yveImUfbKosj6aycUTGGZvYbXu8fAHKFCUK199FYYjh0mPYOAAWwSHmIn/UTSth7Y0gKI1ycJS5eXxQ7P/YHYi0wg5gIZ4xq1AwPvjAHwE5DUN71AxmRPVDnx3MU70dddBunLXXvbUz+5T+zcG0Hq+CVU2TKJPLYgSCfl2euTwKMnb+uZRtFDbJqVZi2OAkAsdyWKxuOLF8xyV857evzAoW4PcJZIBpvm+fvqdMw3jRc04WxqavUArTz0DOb0h3QhxC4zz5+I/BfiRBz6kfU4yp2FfUVCTO+r4BRQIv2HMmnF6Egmc7KbRPEzADLpQx7jxHg+x7e6LSzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAp415GCCvZCDJr35rA1xCvBSXbS4RtA8vzZSdUa02c=;
 b=QiBUu7w2L5ZbuSXhT70bTYLZgGKegOq21NDCmmMjsZG8OyBqTxws1nmKXAOKb2Y5obkrF/0yl+z6tq82qmQIMHEft0h555qZfEJ347ZA6+a6uA6FEuCtAxS/REBjfj25/TFdWAEAET6Z2+dTzZdstzg/QM+lvw2kQarYZ1sjatQ9UQay18z48TO2rYWRL3/evjjM91TZ3akz79Y0GOTa85o+guIUnoBrvB5GI+0cF1RRNqb45ptGN5imeWVgZXCraiT3dak3Nc37zd06bsAm7S3YoSzorU3qYSspL0BW1PVD8RaGX/uj4gNW2zXmtH61IUI4EPwZKWu5Pf6F8E7lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAp415GCCvZCDJr35rA1xCvBSXbS4RtA8vzZSdUa02c=;
 b=SBvfuC8dg8QjJ4hcT9hVBBhBkGVOKRWOfLh9gylYCKUAdgz47HL6G2c3fWkAiGNnEzp2qcRgecAISlPR4hc15FHvZspnWLXgfZx9E9lpgm3iGky7q/b2O9sVh4PHZ7tsMwoQKk0bgUf4hgUPuiJJE2N+lZCIGoeTSvNpAFEiPXw=
Received: from DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13)
 by CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 06:54:15 +0000
Received: from DS2PR12MB9821.namprd12.prod.outlook.com
 ([fe80::f91c:af1b:9bf9:7396]) by DS2PR12MB9821.namprd12.prod.outlook.com
 ([fe80::f91c:af1b:9bf9:7396%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 06:54:15 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Eric_Terminal <ericterminal@gmail.com>, Borislav Petkov <bp@alien8.de>
CC: Tony Luck <tony.luck@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in
 init_versalnet()
Thread-Topic: [PATCH] EDAC/versalnet: Fix resource leaks and NULL derefs in
 init_versalnet()
Thread-Index: AQHco+ePoWguyCuyB0mWMzEsnf7NUrWQTheAgAATzACABC4zEA==
Date: Thu, 26 Feb 2026 06:54:15 +0000
Message-ID:
 <DS2PR12MB9821250527F466180B16ACE38172A@DS2PR12MB9821.namprd12.prod.outlook.com>
References: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de>
 <20260222103918.90670-1-ericterminal@gmail.com>
 <6C330635-430F-408A-8AAE-F79DA2573417@alien8.de>
 <CAKNPVZADH3YKKdAostJqZV2U6WT3bqZWetquNHU7y+f7o8Cu-w@mail.gmail.com>
In-Reply-To:
 <CAKNPVZADH3YKKdAostJqZV2U6WT3bqZWetquNHU7y+f7o8Cu-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-26T06:48:43.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR12MB9821:EE_|CY1PR12MB9604:EE_
x-ms-office365-filtering-correlation-id: 1b84fc93-7c4c-4616-2898-08de7503db1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 ZTxgmWsSwO3lba/8Zblhx+7tVyNl8qsU6PWD3MVTAPvfPWy/U4h9tgjbhAXCmxK/oI6yVCnqM8T94UsllFQtcvM7wwYYWvCFcfqIwD1beCo3V1S9XWKOFXHLW57/qLohRw0MFBilU0zDQ8hPZ3SiNm4MK6yOarkNh+L5nfKvRCYE5bvAnu3SNzsoiJF1/yp5cxh5zGpBVHhfr9cj75cA9qI4+dMTCEpF51rQgtSEmDl1Pgy5htWnYGDMqWfh+TQiZLn4dEtCD6AwfLJaK6rO80VUwW+8R3icrvMEjtKvihn0ruNvmytgNFjgBI6r/Mvmz1BwRaq0P5EgrWz7jRbTNFHucCbpf6jM37uWJtmUnhwU6oCTQO2lWCNAgQi8YfFO8Wf8h06yvML/ay4zLr2o5Yoy+/igHdwL2imX3ITJ6IxUZJ8EvTwXbpE9fHN57IrUquG044porxKhMqap1uTlf6vJaaplxpgjlmkaUfAeQ+axFJ/kDFY3ROyh55CxNooTtMcBcOAs8xx4WNKX3weW9JS7yD5Us1yePzxh5OlYZ47roBDWzGGvXA/DBiDA4kdarV77VYxFedeaHAk6ktgdW53wkRffTR0kVeyGrQF4CNpdvLHKwX5RoNJm1Aq8h4W8I6tjYXU5ynqq4hQV/btG0IiWFcDwrfxuIcSeBat1j3/y2ZNvZ8v1KpInfpEP3G7jUZUUh13Jhv8dmE8I8JjaWOQY2ZkF78L1NooEhJlWDc/fvA3PRROB50CoFS6OzEJBALm1L/GRrZS34TeaB1+mJRWOJY2zuq5A3tRpabROK28=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9821.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1JiODdwRkQzMm9iUXM0dWFRM0RKOEdKWTFoTjVidXpSMWx5N1VlaG9Ybzdk?=
 =?utf-8?B?R3dkU2tnMjRSMG5qRHVtMTRFalEzcVU3YWZjcVVlQjM1OTFJSFRRb2MyWkgr?=
 =?utf-8?B?V1B3THZ4Z29xWGVHNXJjTWc1TzNlRXQyRWF5N3hxMUIzL25idnBiMjdXMUNn?=
 =?utf-8?B?ay9KWGphc0ZsRVNVOERKK2pPVUNMbGRrZk1CTUs0VEsxSUFBaHQ5eHEweDJa?=
 =?utf-8?B?Qm1ENTZzRFVZd3RCQVE4SjJqVFU5N0lFTzdiSXJMUUVqQndVbE02RjllUkww?=
 =?utf-8?B?S29mQ2ltSjRvdW1RQUhJeFF6NEp2SEdWd2dDNmE0bkVuQlpPcnhMbmFRckFu?=
 =?utf-8?B?MDdHMTBidzR6RjJmWG1uRFl4UmUxTDljaml1VmhTeDh3cWgySzVLWDk5K3Qx?=
 =?utf-8?B?OE5DcXlqMGdKa3pNV01pYWUzdUVkVkh5b0hkYlJuMlN1eFRIbTFPN2V4blZO?=
 =?utf-8?B?amwrY284L0JuQ2ZnTkxyUFAvOElJd1llN3IvS0xQQVFwYW5uS1BCeEVQLy9J?=
 =?utf-8?B?MjExbnJ3cHF4RW9YUTVCRHNQZmYrVEdnNW5lVXZWN3FIcmErMWpBeGdsMEJV?=
 =?utf-8?B?QmVGWlIwUGk3VmVpRCt5OVZMNnFLLy9PRHZYUXBnVy96M3JyVy9YZzM1QWg2?=
 =?utf-8?B?VnpGZ0FnbnFIVFdSWVpGYUhLcG5Ocm5XSTF4SlZ3aVQ1cTVNRElkUVJCMWVv?=
 =?utf-8?B?MWFocEFmZ0RRR2hMMXY5M3JUNDBtYjV6VEtQNmVqYWxPL2RhMmt1QTBkUWNJ?=
 =?utf-8?B?dksxNDUrT0ZVZ1M1L1BMZFltOUFUbURHNFZ3TlI2KzFLNnQwYjRmODF4S2t6?=
 =?utf-8?B?MGduR1VEblR0NkQvK0xRQnVGNUcxTjV1bGtmY0JreENrelRaWnZXTThNRnhy?=
 =?utf-8?B?SGZ2a1ZicVZrNWlDc1FYcGVPZ25wUVgzdFRIZTZYV1U1amtzV1pFcXJ5clNq?=
 =?utf-8?B?a3pwT0ZXZmZBbncyVE8vd2RiY01zMmVoV29jYTZpb2M4dTAzZTQ1ZjVNM2lN?=
 =?utf-8?B?Mk14K3ZXM0huQXNIdXArenlRS0pSYjYyU2V6b3k5a2ZibGxycnV5b3Brc1JB?=
 =?utf-8?B?NEI4VEJpL3p3czYyVEZUY3RiWFMzMTJpMXluekxQV1NpcVBRZ2EwbUdweGdC?=
 =?utf-8?B?UXZLMHhIcU10TVVFS2h3Szc4Rlp0WVNReTdZVGNpVmxGOExJL1NNTng4SEtN?=
 =?utf-8?B?Y3pzUzhnVDd2cTdEZkp5NUhvanByRkpqZExEVnZKVHl1dWUxd0VFMEpTR0RB?=
 =?utf-8?B?QmtxaWt5TGxuV1JZNWZJRkNCK2FzN0RJZGluaG4rSkM5SGRGNVFOanQwbFNG?=
 =?utf-8?B?OVhiZXJqd0VmVkl5WGpYUFlFRjd5SWxEMjJEZ2Jkb2Y5b3ZUTmZzYU1pZUty?=
 =?utf-8?B?dUFKeHRIMjJnRFROUFdwYm1kUS9FR3FGalBnRklOTHRZakRqMlJqK0Z2cXpO?=
 =?utf-8?B?aUhJSzhIK2c3QnQvVGRhakZqb3ZFcUJXUFdGOXV1UjRmaXNQMU5VdG45cTFM?=
 =?utf-8?B?WHlpaWdWT0xZa2F5NXEvZG12bWJNcXdBTFFZN1VDOElCb1dyOTdna0dKeEI0?=
 =?utf-8?B?SnNiME9WVWtxSmVpK2M3NlAxVFp1akE3UWZzS3lkWjY5TzBDOWpLRTgyT2RH?=
 =?utf-8?B?TXJnenpYOEhvNmcvdW9jNHpCQ0ltRnJKV09kRENMaWtQMFhQdXBrRXFEL1Jv?=
 =?utf-8?B?ZVFYaG5RaDVJeHJFVTk1RjM5RElIbGthLy9EdGsxRURPbEJjVVJQWlhaVEFl?=
 =?utf-8?B?QUZtMWxyV2RNOVJzeU1ra01YTjAvVVVkQk1lZytrN3NKdGFPZTZwUTFtSm1I?=
 =?utf-8?B?ZkhFQzlQanZKVjFDUmcrd0hIQlhzUVprWjlRVWVFZFJzdy9xTlZ4enRvSlJO?=
 =?utf-8?B?ek1tVlgwOEx4MC8xZjQ0MG5MWU1xV0YxUDYzZW5PTDZvVTU0ckI0TThQRjBI?=
 =?utf-8?B?R2dSTnlkS3FrOGtENHBwbmQwQVdKeWl2OXYrQXZ1T09qYXBnOGE4SEMwMlZX?=
 =?utf-8?B?L3dvT0d5eGlFRkFuSk5FbEh5dU0rZEoxMGFLeGRzakxydkpWRXMzVHBpcGlP?=
 =?utf-8?B?VFpyUUJnd2lGakh2bmFRNGh5MTFtUVdDMmg3dURZRWZrcW8xV1NCUzN0N2RM?=
 =?utf-8?B?dFczaVFYVndrVTM3QzdybHFMWUMvL25ZMmh3MTRiRnEydkp5Y2NPdjJEU21q?=
 =?utf-8?B?VXBFK2huRDEySkQrTDNtWmxreUZ2V0lJRXFUVzFKc3MrSTVhZXdqUi8yRWJl?=
 =?utf-8?B?UkR3Vyt2WDdKMFZLazZvUytWaHBoUXUrclZlSWZpdXl4cEhyYVFROEZsWHJu?=
 =?utf-8?Q?5INR/+wL2eKckbSPN4?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9821.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b84fc93-7c4c-4616-2898-08de7503db1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:54:15.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlkkrTD81zRVw/0b2vNNkVH4Ea40qvDqMyB0skrsJiFt3h7V7qw8VQxx3CPxrAD0lyUnHMSWvTk3ajNO2c/rTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5749-lists,linux-edac=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shubhrajyoti.datta@amd.com,linux-edac@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:email]
X-Rspamd-Queue-Id: E0B871A1786
X-Rspamd-Action: no action

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljX1Rlcm1pbmFsIDxl
cmljdGVybWluYWxAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDIzLCAyMDI2
IDg6MjggUE0NCj4gVG86IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDYzogRGF0
dGEsIFNodWJocmFqeW90aSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+OyBUb255IEx1Y2sN
Cj4gPHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gRURB
Qy92ZXJzYWxuZXQ6IEZpeCByZXNvdXJjZSBsZWFrcyBhbmQgTlVMTCBkZXJlZnMgaW4NCj4gaW5p
dF92ZXJzYWxuZXQoKQ0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9t
IGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBh
dHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIE1v
biwgRmViIDIzLCAyMDI2IGF0IDk6NDfigK9QTSBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5k
ZT4gd3JvdGU6DQo+ID4gQW5kIEknZCB1c3VhbGx5IHNheSB5b3UgY2FuIHRha2UgdGhlIGN1cnJl
bnQgZGlmZnMsIHByb2R1Y3RpemUgdGhlbSBhbmQgc2VuZA0KPiB0aGVtIGFmdGVyIHRlc3Rpbmcu
DQo+DQpJIHdhcyBvdXQgbGFzdCB3ZWVrIGJlY2F1c2Ugb2YgYSBwZXJzb25hbCBlbWVyZ2VuY3ku
ICBNeSBhcG9sb2dpZXMgb24gdGhlIGRlbGF5Lg0KQlRXIEkgd2FzIGFibGUgdG8gdGVzdCB0aGUg
cGF0Y2guDQoNCkZlZWwgZnJlZSB0byBhZGQgbXkNCg0KUmV2aWV3ZWQtYnk6IFNodWJocmFqeW90
aSBEYXR0YSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+DQoNCkhvd2V2ZXIgYXJlIHlvdSBw
bGFubmluZyB0byBzZW5kIGEgdjIgY29ycmVjdGluZyB0aGUgc21hbGwgbml0cyBsaWtlIG5hbWUg
ZXRjPw0K

