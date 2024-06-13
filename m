Return-Path: <linux-edac+bounces-1276-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAE90760D
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23F11C2341D
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE391494A8;
	Thu, 13 Jun 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILhX1eh0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCD1494A1;
	Thu, 13 Jun 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291204; cv=fail; b=D4boww/Ly+qv2dS4NAijtEU/nj7gvWzVxFuuDFu/H2fpDTtC2c/3EKIoW1m3KSFncN5YyFA6e2Ldc6y6QkIARY+I55HnIvPAtLPJ9okyWFuKpBAPcYhlMcToeFuRjLO3vF/QJII1GS5QfvtK7jQu0PGDHYpbDwp+X7col25NDfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291204; c=relaxed/simple;
	bh=8X1LY7PR6GmIpEZmmt6n7Rwc8V1fs4lLVM/Q+jgpj74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g13C9UnmNHOxc9tYRio3SNgU6yhxc7bwFVxSEmx3m00SC8H4MQpzLwue5RFsh7qUEEZt7AS71iv3ejHD69lIj2eU2Tv295t2D7rDjY966wsXroQDHWkUn78K/5qi6PKnwKjWayG27S75d41SGg1dbLycbtt/vFuHzpPqwM/DCv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILhX1eh0; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaYBJJgYHm864AQ0GyXFt297SO7O1ApBfWJ/ZLJAWaE685evdyca1nmKmRLbiHlstZjC1TL9hw2qF9o91kFX+3oygtssY7I+y7hzr32/2Bi2OaZXVn0FT5PL4eIRpEe3rMtxhgbovB74XN+4ILiLFflggt38u+GG7TBPNZOQ7HUsZKY2hA/LChVsgyEIpUbiIWlKOCI4aRfAEYIO0vAUnzJzvJFKunj+rkpnApZCDjsNq+9SdjBY7mNZZcAa+xVaeNe8CvlEbxaFDHVyfrky3/p1yu9kwx3mu0zAMElN1NgnXezZ/dvd8L5UDcvc8HW/xBlyShnFw7Lm7Q1Zj6g6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X1LY7PR6GmIpEZmmt6n7Rwc8V1fs4lLVM/Q+jgpj74=;
 b=ZfHSTqgAFYofsuVwVSeqK8x9zjfZZqh+Mikb58a+PRiPgPo4fEUuThFaDlDME6fEfmWtwVLPGWb6+qKj4p+EO0BXusKe9mURLgn3qkvDHvBIbSxKZFSgqw3RMEvnKBaXxSReD6nBPF84kXCdHIuEBV4dmKJwL4glbMwCZzEL8cb87614naKjf38DsDajS/Ah00UONNWpOfkvrLqSUCeQttKJeqGQcu153tKyX3+9AQzacR/mSTLL3fJbf1ZSd9O7Ri/TjKXbZTac69tmlCjYZCv47S7F5ImjLU9QKW+Vok4Q+sD38cuAYeZEI3n3Z3Sfrz8B3n18DrVGLSRuYO44nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X1LY7PR6GmIpEZmmt6n7Rwc8V1fs4lLVM/Q+jgpj74=;
 b=ILhX1eh056b4Wp4mK6+eFHLNeVvJidv3ULna7LMnDmAtfypZQkNBxIcpSgMHHBWTOiMKcVbVtIAq3cysLMssNsOzr/vP4FA4rCRrZIEW+lMg92wrmEZLESr6nOc9P7A7A/4PEAj4n5FCQnEEZz/uSwVfa3taYEKfRzlXd2GbIAZhlHk+OcYg/RaRaE10M0pD2xVIe6BlxHGazUH3voeshR1izMk4RZH52O+JcPr9X3fF77UnD7UYshKaxiZ6lLfPEqO1w9RZYz0EZcI4ouA4leicEOzvtp14sxW706sIdSJL4N0Ui0zeH+ZltpAwrOtqKqBK/ACJUHkcDWq7GoW1Qw==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 15:06:39 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 15:06:38 +0000
From: David Thompson <davthompson@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
CC: "tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, Shravan Ramani <shravankr@nvidia.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] EDAC/bluefield: fix white space in
 bluefield_edac_mc_probe
Thread-Topic: [PATCH v1 1/2] EDAC/bluefield: fix white space in
 bluefield_edac_mc_probe
Thread-Index: AQHavQAtfRiejQT/IEmFUIdYnmxkS7HEjHgAgAE/NsA=
Date: Thu, 13 Jun 2024 15:06:38 +0000
Message-ID:
 <DM6PR12MB553462599AA57044F6E41DF4C7C12@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20240612193831.25913-1-davthompson@nvidia.com>
 <20240612193831.25913-2-davthompson@nvidia.com>
 <20240612200056.GGZmn-eO15ePolbAPo@fat_crate.local>
In-Reply-To: <20240612200056.GGZmn-eO15ePolbAPo@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|PH7PR12MB9204:EE_
x-ms-office365-filtering-correlation-id: 565ef688-edf8-4147-151b-08dc8bba6cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkI3bmkxTWg0aXBxTVBNbzRDS1F2ZDBsQnAvczhDbG1lUGpwRlBvSy9DMTMy?=
 =?utf-8?B?dGR6ck5xcXA0b2tBS3RMZEhwV3RaR3JnKzJCbVFtbXBTUmVBK01nd2hMZ1B2?=
 =?utf-8?B?akVDTC9pTDR3K3k4LzdIZkJyV091eVUvNWg0ZSs5VGp0MlFSZDg2dVhUSVNQ?=
 =?utf-8?B?dWRyYk5jVTdlNGQxZWZXdlptSkV5eGVrOThHeWMwRE03Wml1RjVnVGx2MTdS?=
 =?utf-8?B?elVpdUZnVlVXdkZoUm5UQjlwVmN6NXd2VWdWUDkzdG1lYWdHRXl4L0pMUERt?=
 =?utf-8?B?bW9mN0VUeitibFZvcnpsTlVlYzNpQlltdG5UWHdzUUlNNDRnMjIybVJqYUtx?=
 =?utf-8?B?NkdEeE5uVklRT1llN2JQUGd4S2JDazhiK1lLZVh0VmRTc2F6YTRlTlg0bWUw?=
 =?utf-8?B?dkMwNTFtRnlNNE4vbm44OG9ad1k3cGtwZ0FxeUtsQ1ozK2NOVk9FaGcva0FD?=
 =?utf-8?B?eG1rYkU2Wkp2cGRreVR5Ump4T1ExN0xrelBSUzlSM05NRmR3NG9vZjdoOWhY?=
 =?utf-8?B?N0xsNENocWkyOFlZM3IxUmlpMCs5ak9kVUxXYUoveVlzU0VKM1V2M1N5Lyt6?=
 =?utf-8?B?cEFUN2ZvSmVwUy9MaERCRE90K1FINWFGZDhxS2V0UmRxZnhMK1VFOGt3WXA2?=
 =?utf-8?B?WWVNYk1rTTVVd1RMLzk2NTllQWFHaHNuYnpZbGh6azFibE5hZkNMNmdRcFFm?=
 =?utf-8?B?c3oyb2lCaU5TeGhqM1RlRHdjRlZ4Y0ZFaVlrbGpQSDE4Q1JHbThVaC8rc2p4?=
 =?utf-8?B?VnFveHcvM1FLUHJFMktLQTNLalBrazEyU3hGdVNXSW84SDl5WE1NSEo4VUQx?=
 =?utf-8?B?SnhMOUNGeVBEVjh4OURlbUZUbnBuaGx5ZzNwUE0waVJOWVRpQ1NOc2puQllX?=
 =?utf-8?B?S00rL3M0a1NEN1FOMThuNWlJR0pwQTJxam00RDZZWGJOeGhscy95NUlTbUZC?=
 =?utf-8?B?T0pxZkFmZTNJMEx2VlpEREMzODB1eWdMaHNGSlA0TzBXQXVtN0llb25TRnR4?=
 =?utf-8?B?aE95S3M5bkVhL0w0Smc2eWdCbnFVNkVHTDFsYzVmeXNDZy9XY0x5OW5yUTFW?=
 =?utf-8?B?ajlCQTJxSjdGcUFEUFBnRUZGbkRTeUlhUVMzZm9LYkVHbk8rdzBNZFRoNU5N?=
 =?utf-8?B?dGFMdVB4ZmZFOVBRQzljNytrTUpJaTRkNkJzRWMvME9SYklWY2FiY1haaXVS?=
 =?utf-8?B?OUFRUElPNDFNTFlCY1JGa3ArcnZlbHFrN0VNYld5U2hORUw5L3lKMHNhRUFj?=
 =?utf-8?B?enpMNlBHeTByM2RYQ0lRREdTZ0RiVlVkZTFLeS9OdVY3ekprZGRJK1dwUkUz?=
 =?utf-8?B?a0RnYW8vWFZ4ZEdaeHFQOGFkSzdXVjYvcVBwekRudTE5MndGZTdFNUpuR29S?=
 =?utf-8?B?bU4yWDlHY1B6cFNMQTBrd2czaUFMYkROcVhmOERkeUZVb1RrMjBzZ2EzQ1h5?=
 =?utf-8?B?TUxXK1UwVXlWckVtcG1Uc2poVTd1OHhIT01KWjRwYnNabTN3ZkJnZE51cUNs?=
 =?utf-8?B?cHBqRkpmNlR0d0xnRG9DMW1CVFFPMXlRZHBOM2xNckVianpoNndIOGNTZU1N?=
 =?utf-8?B?T3VQVmNXUTBQenpjUmowa1JIdmFMbHRTN25sNldDM3JEc3lKRDNYeFRUUWRF?=
 =?utf-8?B?VlJldnZTV1BxYWhyUFBldFNUWlF5eXlVZEZWb2pyU1A2UGczMFdxU29CSEZL?=
 =?utf-8?B?c1FGVmhCTWlteVZVYWVoV1Q0OURQMzI3YTZGenBsVUV1QnBQQkMvM0dycUlq?=
 =?utf-8?B?UUF3blUrVmdMS0M4azFSNzBpQzRLbVJEQjJpNWdySkJ5emVoNloyM2pqejBq?=
 =?utf-8?Q?xKq/DDBde31ccxFOMT1s+0/CGArrB7HQigNZU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGxlTGlxNDVZMUdTeUJPZ3VRR0E3VXQ2YThSMk1Ka29ESzlMTUlqRE9SSHV1?=
 =?utf-8?B?alZEWGV2Q3VudEVKUHBkdjJBYjkrdEVXZ2k0MFB5V1BWaXVyWjJPZUxNdnhY?=
 =?utf-8?B?SjlCQUwxSDJHZit3YSt0dytMTUNWVDJmS3dKN2djRDlJaERHUU8zMEhPOXBm?=
 =?utf-8?B?dHkvVE1mdXdlenJYUlBZR1BPQVBMeXVmRW8zYWxOTU1zNnc4U24xSjh3Z3c0?=
 =?utf-8?B?VFZMaUxWM2IyYmpxNU9Ucmx3QU9KWFJXb1ViYlROQU9XSjl4QkN3Q0ZJZU96?=
 =?utf-8?B?RGROTWRsUzhxVGJLd3FSbTAzSk5FUWp1bWlyc2RTRnlpVFcxak5mL1pyR3cy?=
 =?utf-8?B?OWlKeXc4MUxVYjlMWjM0c004eUdIa2E2NXRrMWZ3NmJ2QmdpTkd6bElQdm5E?=
 =?utf-8?B?Y2VGc01XQUdyRVdwNzhnQWZCcXYxN3UrWk1QNW1RZE10RUJNSnluMERXTHps?=
 =?utf-8?B?SndnQ3o2T09TYVZXSTRudW9uT3RlVFN1dE9HeFptV09YcUFaWTRyaEJLRGwy?=
 =?utf-8?B?R3FyQlZ4ZmhnL21xSmx2ZUdhR1lySnJFenhsclB3aXVLZUMzODB6OFRKRWY3?=
 =?utf-8?B?dFVjVUlIeTlNU2lwZlltbTZqQ1g2V2pBSXE1Mm9xSlhmVEk4VWpOcWg3WUxn?=
 =?utf-8?B?eEtKaU9BSUlmdTNDc3RKMDlVWCtHOWgwbmVQMVhwVHhLK0VESmd5VDJFVjdK?=
 =?utf-8?B?NkExaU5qVGVXbGNKaER0R1BVNFRLZEtoUVBGQWpxK004WEV3SnpzSVdGU3p2?=
 =?utf-8?B?eWhYMHVhdWVKK2hVRGR0eDEzZlFnT1RjWG94YlVDaXFudTdEV1hTMWdLa2V6?=
 =?utf-8?B?TkRrZkpTQk4zR25sbnA2UWkycmI5TkpPSnVmUWJJK3lqQ29IUTdVWWZ5ejBS?=
 =?utf-8?B?Z3hXWEVncE04TEdCM3p6Q3hUQ0xmMC9VQWZlZDdvSXVwVUdnRmVOZ0hubkJt?=
 =?utf-8?B?SVk3NDlpRmEybUhmelFzOVBxczdhZzB3NklNc2d3Uk4xclJUU3NjRThJekU3?=
 =?utf-8?B?TWtxaFdkcTk5dzUyZjR6K01uYi8zdEVteUgwSjQ5V2hsLzA2NitOcmJrOVRw?=
 =?utf-8?B?WnFaek4vQVIvUDdVZTQ5U2xLZ0JTZHArWDdzdUl5SkxPWkI1TUs0TVluNWdy?=
 =?utf-8?B?NFpXVTJOSHJING42d1Y0SWFLdm1uaitpcFVlL243Y1FtVmRaOXU4NlFuMjVO?=
 =?utf-8?B?R29GeCs0Ym1OSHNqNTRoa2ZTVFprbmxWdVpXNVQvZVFHUWtEQTNpeVVwQlU0?=
 =?utf-8?B?cWIxNjQyR2tjMVc5SmpkdDZmQ3I1ekFoaHFIbkhQL214aU1CSlROMDJlaTVs?=
 =?utf-8?B?TzVOZGZQcytKTDJMenR6TVNNV3dub1Q2eU1JWlpEeW9hNjFPbmZGSFM3bDVq?=
 =?utf-8?B?UFBMZ0pmQktUUnYvYW9Wd2VNY3pTeHRVajM1eittcTZiR0JKeTFDZUxValJH?=
 =?utf-8?B?RG40UmhSS3ZDSjN4ekZ6ZFUrMXlrOTU2azJJelBnQjhWL0ZrdVFlcU53VkY2?=
 =?utf-8?B?THUyMkV5blR1UkxDZCtzcGQ0SGxIYVZ0Z21xQnRPUktTRXRHMkd5R1FnTThJ?=
 =?utf-8?B?aTlTb05NVVl0dUdWbmRpRU5CWU5xc1JJQm9YUDdDMmNJUllKMGI0cWV3SlBQ?=
 =?utf-8?B?VEtNZDFEY3hCbGpDYXhKcmFaSnZhNWpHcnVaTkcrUTlpN1ZiM0JWVkpTTENx?=
 =?utf-8?B?NlN0NzBaZ0hyTEhIbzVrYWZvV2VPaDl4T1FYR1FHWUV3bExxdVExdGdjNVow?=
 =?utf-8?B?TnZEMGdVRklVYnZnVjNPYnVqYWF3MTZpUU5Fa1h5UXhDWnRSY0J3UkxBUFdK?=
 =?utf-8?B?d093OTZlQndnMHlabkcyeE5adlZvczFQL3JDdlkrMDN0N1Z0VWpOVlROL1lC?=
 =?utf-8?B?TDVFQXpwREdQL1BMV0d1eE9PNmpwWlp3bzlrMFpqZTlhTDB3ZFZEMTJMOW1q?=
 =?utf-8?B?dndlQkVHV0JJY0RCTy8xeDV3dHEzandnaGtrSmNYZ3poZlNwNHhKYS9oWHRL?=
 =?utf-8?B?ZDNZWWFWcnVsL0dHS2NOcWZ1U3JmYjRScmJMM0RpMHcvbEdNOTdYOGk5VWF6?=
 =?utf-8?B?cWp5bXovWThKeUM2c0JseXBKT2hMKzRZNG9lOU5yMTA0ZysxbU1jQ1QvSmlp?=
 =?utf-8?Q?08aP1HP/yL4cKHHcUlDvJ6EhG?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565ef688-edf8-4147-151b-08dc8bba6cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 15:06:38.6102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpcS1I63YGEKxL88S312bqbEo3OSirN66A0N2nLg96a2ahyPK4qDOGDwkHYQzxPS0YoemC1GqCNMfhZDJOQvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDI0IDQ6MDEgUE0NCj4g
VG86IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiBDYzogdG9ueS5s
dWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOw0K
PiBycmljQGtlcm5lbC5vcmc7IFNocmF2YW4gUmFtYW5pIDxzaHJhdmFua3JAbnZpZGlhLmNvbT47
IGxpbnV4LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMl0gRURBQy9ibHVlZmllbGQ6IGZpeCB3
aGl0ZSBzcGFjZSBpbg0KPiBibHVlZmllbGRfZWRhY19tY19wcm9iZQ0KPiANCj4gT24gV2VkLCBK
dW4gMTIsIDIwMjQgYXQgMDM6Mzg6MzBQTSAtMDQwMCwgRGF2aWQgVGhvbXBzb24gd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCByZW1vdmVzIGFuIGVtcHR5IGxpbmUgaW4gYmx1ZWZpZWxkX2VkYWNfbWNf
cHJvYmUoKS4NCj4gDQo+IEF2b2lkIGhhdmluZyAiVGhpcyBwYXRjaCIgb3IgIlRoaXMgY29tbWl0
IiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIEl0IGlzDQo+IHRhdXRvbG9naWNhbGx5IHVzZWxlc3Mu
DQo+IA0KPiBBbHNvLCBkbw0KPiANCj4gJCBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRh
dGlvbi9wcm9jZXNzDQo+IA0KPiBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCg0KSSBkaWQgcmV2aWV3
IHRoaXMgc2VjdGlvbiBvZiB0aGUga2VybmVsIGRvY3VtZW50YXRpb24gYW5kIHRoZW4NCndlbnQg
b24gdG8gY3JlYXRlIGEgdjIgd2l0aCB0aGUgdXBkYXRlZCBjb21taXQgbWVzc2FnZS4NCkkgYXBv
bG9naXplIGJ1dCBJIGRpZG4ndCBub3RpY2UgeW91ciBjb21tZW50IGJlbG93IGFib3V0IA0KeW91
ciBwcmVmZXJlbmNlIHRvIG5vdCBoYXZlIHRoaXMgdHlwZSBvZiBwYXRjaCBhdCBhbGwuICBJIGhh
dmUgYmVlbg0KdG9sZCBpbiB0aGUgcGFzdCB0byBoYXZlIHNlcGFyYXRlIHBhdGNoZXMgZm9yIHN0
eWxlIGNsZWFudXBzLCBhbmQNCm5vdCB0byBidW5kbGUgdGhlbSB3aXRoIGZlYXR1cmVzLiAgQnV0
IEkgY2FuIGRvIGFzIHlvdSByZWNvbW1lbmQNCmZvciBuZXh0IHZlcnNpb24uICBJIHdpbGwgc3F1
YXNoIHRoZSB0d28gc3R5bGUgZml4ZXMgaW50byBhIHBhdGNoIHRoYXQNCmNvbnRhaW5zIHNvbWUg
bmV3IGZ1bmN0aW9uYWxpdHkgZm9yIHRoZSBCbHVlRmllbGQgRURBQyBkcml2ZXIuDQoNCj4gQWxz
bywgZmVlbCBmcmVlIHRvIHBlcnVzZSB0aGF0IHdob2xlIGRpcmVjdG9yeS4NCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IFNocmF2YW4gS3VtYXIgUmFtYW5pIDxzaHJhdmFua3JAbnZpZGlhLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9lZGFjLmMgfCAxIC0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYw0KPiA+IGIvZHJpdmVycy9lZGFjL2JsdWVmaWVsZF9l
ZGFjLmMgaW5kZXggNWIzMTY0NTYwNjQ4Li4xZjZmMzlhN2RiZjMNCj4gPiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2VkYWMvYmx1ZWZpZWxkX2VkYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRh
Yy9ibHVlZmllbGRfZWRhYy5jDQo+ID4gQEAgLTMyMCw3ICszMjAsNiBAQCBzdGF0aWMgaW50IGJs
dWVmaWVsZF9lZGFjX21jX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gIAllZGFjX21jX2ZyZWUobWNpKTsNCj4gPg0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAtDQo+
ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBibHVlZmllbGRfZWRhY19tY19yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAtLQ0KPiANCj4gU28ganVzdCB0aGUgZWZm
b3J0IHRvIGNyZWF0ZSBhIHdob2xlIHBhdGNoIGp1c3QgZm9yIHRoYXQgaXMgYW4gb3ZlcmtpbGwu
DQo+IA0KPiBQbGVhc2UgZG8gbm90IGRvIHRoYXQuIElmIHlvdSBub3RpY2UgdmVyeSBtaW5vciBz
dHlsZSBpc3N1ZXMgbGlrZSB0aGF0LCB5b3UgY2FuIGRvDQo+IHRoZW0gd2hlbiB0b3VjaGluZyB0
aGlzIGNvZGUgYXMgcGFydCBvZiBhIGNoYW5nZSB3aXRoIG1vcmUgc3Vic3RhbmNlLiBPciB5b3UN
Cj4gY2FuIHNpbXBseSBpZ25vcmUgc3VjaCBtaW5vciBpc3N1ZXMuDQo+IA0KPiBXaGl0ZXNwYWNl
IGNsZWFudXAgbGlrZSB0aGF0IGdldHMgaW4gdGhlIHdheSBvZiByZWFsIHdvcmsgYW5kIHByZXR0
eSBtdWNoIGFsbA0KPiBtYWludGFpbmVycyBhcmUgb3ZlcndvcmtlZCBhbHJlYWR5Lg0KPiANCj4g
U28gSSdkIGFwcHJlY2lhdGUgaXQgaWYgeW91IGNvbmNlbnRyYXRlIG9uIHJlYWwgZml4ZXMgYW5k
IGltcHJvdmVtZW50cy4NCj4gDQo+IFRoeC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+
ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1h
Ym91dC1uZXRpcXVldHRlDQo=

