Return-Path: <linux-edac+bounces-745-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DEB87605A
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 09:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF48028151F
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 08:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B74314A;
	Fri,  8 Mar 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zqMDu1P5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839844F5F9
	for <linux-edac@vger.kernel.org>; Fri,  8 Mar 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888112; cv=fail; b=vFBmXm4sUZz8cqhnA5t0NOBE5baat6roj058HHGJf/nBH5sbQwTNWW5qfhhttUuGUx1EPVpl0AtvGHz6sV2nWGb2KCLxwS9RMeoF69DROlgxROiDn9q4T+t7D+xxfA90MnKZYvrQ/i6/Dg39MEY3ANxKtRoHofCj+hosTO20JLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888112; c=relaxed/simple;
	bh=XQYMa8KqVMdA6sbsRxddeV57XFEeJQTxav46p0F2oo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGwYvJIgF62VKXuln/XxZRz54a73KwrqwX3eJCM8rUc+ksG9Ir7pqT2kQguF3JEw7TCjqUAJKmDUhqnr7W89lKHRXOUmPhj6ZtPAZtIArKXkHwvvhMMVEgcdT6MsWciHAayIAP4l1RDvkpZkTu/T1yxoV6zuTizRAVWigbRc8lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zqMDu1P5; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGiPIJSPYr7Wgz0fZpdd1R/rNRmphaskcpo40eU5/JsluBQutRS3pmecI7Ba+Fet+M8lbMPdOraupz/YYIPRtJnt0GMBGscX9GxwghTFEuEnQnfq65IJmHAhKCNOPAFlzA7IfoDX0ChZXl+Kqy6dw9V7vLIULtRbfZK3MH6zi4qD7RTt8oTtv3a27vZ3BXO0PCUnexGPUQHUF3Wi22bwxmlFnrEPaXrgsxckJ9DRClVzGfRHlXJEi4B0FwylDWPS2OUKqohU7Kx14MUE+rp9kWWs6HNFf8CfC4qeE+JWU3ziHo8942ApVpk1dBMZzf542QH4YRq/hp6gk0VV49P79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQYMa8KqVMdA6sbsRxddeV57XFEeJQTxav46p0F2oo8=;
 b=mOhI2Bxddpt50ylAAU0pAe4buJS/Tu0DEAVqHg6ZQmQT46LFXfUZfFTN4vSIhewPRLCbGUFQstBUWKysqaGnxKHgogc0FyEm+zvnfpGPCrNAXop3Fi1SocVRGi8x4F9MWpWeozci0y4E27oi0cnovxQPUP6Atu0CNKa9qCE5Qz1ntP351LMC8rlTkllPBFfYR0EecURKFRtgwFeDSaAHdz6aBa1q+WSMoVeNUQoF0qm875F5qbvcCrvRlZQUawHdLSTn1srsyfRyx1vhZ57CsyfgFO7JlncovvLPFXJmKbINH7SzKIiDY+9Cz6u4cbk5+iU56xGsZ+wo+a9LDloSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQYMa8KqVMdA6sbsRxddeV57XFEeJQTxav46p0F2oo8=;
 b=zqMDu1P5Z8M2S1a53t4vjiufML6BronPQCkP7gB5zIU7XxLfsj9ZGE0qEx547KoXeZK1JfXNs0CHqCn/3+2McZb/3f3lqlZPuDXoYYh0hCyTpvGQYDoR9vjT+8TZS4ZR2JxLiuovuhujbaYN9uKFx9LZdQH8MMFejoegOA8q0Ho=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:55:07 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::7cbc:d8b7:696e:7edb]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::7cbc:d8b7:696e:7edb%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:55:07 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	"Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] EDAC/versal: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH] EDAC/versal: Convert to platform remove callback
 returning void
Thread-Index: AQHacTXeq3nfty+vi0yGuKIyQzN/uLEtiZhw
Date: Fri, 8 Mar 2024 08:55:07 +0000
Message-ID:
 <BY5PR12MB4902011971E052DFFC42D2D881272@BY5PR12MB4902.namprd12.prod.outlook.com>
References:
 <83deca1ce260f7e17ff3cb106c9a6946d4ca4505.1709886922.git.u.kleine-koenig@pengutronix.de>
In-Reply-To:
 <83deca1ce260f7e17ff3cb106c9a6946d4ca4505.1709886922.git.u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=371d6bb6-7ddf-4162-a3f3-98cee453c19d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-08T08:52:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|MN0PR12MB6053:EE_
x-ms-office365-filtering-correlation-id: ab5119e8-e1bc-494f-a51d-08dc3f4d743a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nExxQgojU6DDiTEJARReomqoj0pW88tOmzOfvx02DijxCeNBsYvUU24EMNRvYJOvu2Xnl8JEgGTtxy3BpMN46ECu7PpXcEhmBmnJTjS25Ln62e0qHSjgRgc+DEqn75WwK835ZosOG4tGT0SXUrnA/lYaKiWR2keBgjQIg99PayNnIxj7LzpfVhjMjvV7MRUzDCp8EJIp9rkk7tS0Xqh7MKhSgsKsRs72MsvWpoaAdnVdDIYM9OJnhFVGEwTUfP8+vKuCLyZLtrKJfsO00nqB5NASKXuTIk85tnjJzKFar003sQbSX++nhpMfCLcHGurna2Luv80h2HR4xX6Abk5Ux+D1k3UNjats3YR1ZGoVwy57BYTWElC9MoQUkoVOMDJwn63MRXWADlESjCY17jzLpdsenxkcSBsgWCXHNnG3liEeMMKwB6poUgsfYkdulcsLdAOI14ZVYxP1qOnetB/khrNI5tgXGLHTA2RWwypJzfgMtzbilVcHJVI9+5HZJFicjDzgiKrl2M4bxpz5ki3EXIXJAkkeq1Dl4UEm5YCkUmqkqHOqwZWR62OwS+KcH7qHGyXCjB9BKA2Ji4iQ0sIQDS0mD+Yb156nmeeIQgRmrO0qonlhTSUoxolRsEOIQ+StwVD3yXvMgQWI/sC2o5/ABy1ICQzQOSbsOVYGiEF8xXs0btzDeAkhEQ9vqhIAmcclJuYZPbQLaJyPD3jVg8sS+WxMmSUKjO2LmFudPBFfOqI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0RnSDkxbjFWU2lPdGVFa2FUYlVoczNCczFGQkNlNStPMUNVZnE3ZGpKMXQ1?=
 =?utf-8?B?c2c4Q3A0OWRWWUpTaFNHQVpjTTFxWGgwbHRCODA3YlRBTmRxRE9SNlVHRTkv?=
 =?utf-8?B?eVFDZUNDMlU1ZGY0Z2RhWGd0TE11WThJUVJYZmFBNTA0aVBPNHI0enNpdytl?=
 =?utf-8?B?K05kMnNicTBNTGUzOUpYM3lCTnRVMFFZalZMTW03TWJQT0h4bm91ZHN6RmZ6?=
 =?utf-8?B?QzRZSFRoSTZBSElQUkN2Mys5dUhVQldRRnBsRDkrZVRVa2dMUldlSUdEQmJX?=
 =?utf-8?B?UDdUVnFFMVBxSXNLTlFNNFRQR2xucTBENFJyblVMbFB0OE9GVGxmYlR4ZTZF?=
 =?utf-8?B?Q0RYSGpyaTRKKzlXRFVGQ0swQWhLWXBxa2JLRm9HNDk1bERhaGZjSkNYMmJl?=
 =?utf-8?B?Tm5iZFFrakVEaTNUOWt4TWVaOC8vbUwwOTEzbHJjeGY2Qkh2MDBqa0dFUGJ5?=
 =?utf-8?B?L0FhQ3ZCZXBxYmFkcUhxU2ovZUNKanlma0U4cGExaXJGNVB3UTh6WW5ibjlX?=
 =?utf-8?B?TUVFVERDMzM2OFBRR2hMdy9nNVVCelhXTWJXVm9qcjY2VU9NMElBaDk3SEF5?=
 =?utf-8?B?ZmhKNEhSKzdmSXJlOGpOOGx4UDM2enBZOEREb1BMV0hKMjVsaE5wOEZrYm9n?=
 =?utf-8?B?RmhROTZpU1BzMzlZcFNkb0R4dERYbTZISGRvSVlQbVZQZ1JIbTlxWEpRUkc2?=
 =?utf-8?B?Vm5EQ0xNazhMeDRoNmRSRy9vQTMwYWpPdkE1cDJzM29OQmRJZWhXTzhySVBu?=
 =?utf-8?B?dGFXUzNaMWFtaGFTNHFtTjZENkhYRGhqdmFQMC9lQjJHSjFsd0N4azBTM3pX?=
 =?utf-8?B?L0Vqd0hwaG9oUllNOHpjOHZKaUhUdDV3dmFhSExBNXl6RjVXaytodWdjMXl2?=
 =?utf-8?B?SE50Q1VRdWpiU0NFVTkyWXpvZm9MeEo2VmRnNEFLWm02TEE3U3hTQWMxeG9C?=
 =?utf-8?B?cWh2OUo1US96cUJHcENxMUpubUJIemhUTDhockVUUFVPS2pIa3JyTGptL3Nx?=
 =?utf-8?B?UFhuNmJzM0gyRUpsc01nWXdCU2FqVU1mVWFXemJYSVpmR28wTW1MNTRzdWlC?=
 =?utf-8?B?MjdWdTA1Zm1VZ0NSckRpcFNtcmphdVdkZ2VUV1NQd1lrYlR6KzBEbi80UTRK?=
 =?utf-8?B?ODZ2MTFyR3VnanNFMFNVMi9RcTZ6MjVaSVgyQmZGUFF1WWhrK2xjOWw1SHhs?=
 =?utf-8?B?ZUVUaHdhRmxWUWJ0SkxUdTVqczFwL08vNTJ0S3NBblVrdWQ1VkNPU0tZMmFO?=
 =?utf-8?B?VnIvVjQrUW1pTkVMaTRmaEpOazFkVy8zUWYrbjhoRU50cUt5dzhmREdDemRa?=
 =?utf-8?B?aXdDWUdja2s1TktFS3Bmc1VqVzZxclUyck9JOUxvOS84c3djbmtGWng2dUM5?=
 =?utf-8?B?V3RiWitPVjNOdXJ3YlZzb0pZV1ZPd2RoandWblR5RDJBYUJibVY3WkpQc2lJ?=
 =?utf-8?B?R3dJRGRVZnNlUGR2bWI1Z2g0ZkFJSktUdDFhZzNmV3ZqcXJGZFNDQUdLM2sw?=
 =?utf-8?B?dFpsK2ovV0F0bjY1TFd3Zyt4b0EybFhldURGUnBpQ0xRNXU4UGdxVmg1RHRT?=
 =?utf-8?B?ZS9ORDJKbHF2TXhZTjQyWDY3bGVoN0tDYnFJQS9oTzV1cUxXQ3dZUld3Vndz?=
 =?utf-8?B?SHE4Z2RTT1VCZkdmUUxvenJZT1NqeVhyNEZ6THJIa2hvckZxQ1lVaW4zZFRM?=
 =?utf-8?B?eVMyamZTMmFyS1dSL0Z2MXNnM09uODhBZkJvdTdib1FRRGdIWVRTNUN6SDNO?=
 =?utf-8?B?c1NhWnJkRGZrdTNMRWFVUWV5RU9tMHM3NHlZaThYdTVRQkVVWkZBRnJUeld3?=
 =?utf-8?B?bU03ZXRRWmVPSllYTStWUkw1ODEyL1ZHL0NFa0E0NXBDN09Nb0hEa05oSExl?=
 =?utf-8?B?MXJmT0pNSHZuN1EwVVhkVXhwNXhHVUJTUGFnUXM2b2pKcUw3ZHI0cUxNNk1m?=
 =?utf-8?B?OG04TUh1VkpvUlA1cllYU2F1Y3p1bnJaTjcxTTF6MzFzR01vMm5kMm85Q0tx?=
 =?utf-8?B?cW1wdFlxLzdNN3FsL3dZZ2hKL3phMHJkMlZyNjFVZnJKRVUyMTlqVlQrNWtx?=
 =?utf-8?B?dW1oQUFwall3S01oeExjV3ZTbEpBWUEwcW1oaTFsSzRPYWVZQXZrcXpWelha?=
 =?utf-8?Q?rkrU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5119e8-e1bc-494f-a51d-08dc3f4d743a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:55:07.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mN4TifMVACyQoRBMgdflVkU2EtY2uHnpOZB302LSGFffMac4B0B3Y9ZBN1NgdrJpqsvHu+9OUzz5J2p2xg5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCA4LCAyMDI0IDI6MjEgUE0NCj4gVG86
IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPjsgUG90dGh1
cmksIFNhaQ0KPiBLcmlzaG5hIDxzYWkua3Jpc2huYS5wb3R0aHVyaUBhbWQuY29tPjsgQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+Ow0KPiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5j
b20+DQo+IENjOiBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNvbT47IE1hdXJvIENhcnZh
bGhvIENoZWhhYg0KPiA8bWNoZWhhYkBrZXJuZWwub3JnPjsgUm9iZXJ0IFJpY2h0ZXIgPHJyaWNA
a2VybmVsLm9yZz47IGxpbnV4LQ0KPiBlZGFjQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IFN1YmplY3Q6IFtQQVRDSF0gRURBQy92ZXJzYWw6IENvbnZlcnQgdG8gcGxh
dGZvcm0gcmVtb3ZlIGNhbGxiYWNrDQo+IHJldHVybmluZyB2b2lkDQo+DQo+IENhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
DQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4NCj4NCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBmb3IgYSBwbGF0Zm9y
bSBkcml2ZXIgcmV0dXJucyBhbiBpbnQgd2hpY2ggbWFrZXMNCj4gbWFueSBkcml2ZXIgYXV0aG9y
cyB3cm9uZ2x5IGFzc3VtZSBpdCdzIHBvc3NpYmxlIHRvIGRvIGVycm9yIGhhbmRsaW5nIGJ5DQo+
IHJldHVybmluZyBhbiBlcnJvciBjb2RlLiBIb3dldmVyIHRoZSB2YWx1ZSByZXR1cm5lZCBpcyBp
Z25vcmVkIChhcGFydCBmcm9tDQo+IGVtaXR0aW5nIGEgd2FybmluZykgYW5kIHRoaXMgdHlwaWNh
bGx5IHJlc3VsdHMgaW4gcmVzb3VyY2UgbGVha3MuDQo+DQo+IFRvIGltcHJvdmUgaGVyZSB0aGVy
ZSBpcyBhIHF1ZXN0IHRvIG1ha2UgdGhlIHJlbW92ZSBjYWxsYmFjayByZXR1cm4gdm9pZC4gSW4N
Cj4gdGhlIGZpcnN0IHN0ZXAgb2YgdGhpcyBxdWVzdCBhbGwgZHJpdmVycyBhcmUgY29udmVydGVk
IHRvIC5yZW1vdmVfbmV3KCksIHdoaWNoDQo+IGFscmVhZHkgcmV0dXJucyB2b2lkLiBFdmVudHVh
bGx5IGFmdGVyIGFsbCBkcml2ZXJzIGFyZSBjb252ZXJ0ZWQsDQo+IC5yZW1vdmVfbmV3KCkgd2ls
bCBiZSByZW5hbWVkIHRvIC5yZW1vdmUoKS4NCj4NCj4gVHJpdmlhbGx5IGNvbnZlcnQgdGhpcyBk
cml2ZXIgZnJvbSBhbHdheXMgcmV0dXJuaW5nIHplcm8gaW4gdGhlIHJlbW92ZQ0KPiBjYWxsYmFj
ayB0byB0aGUgdm9pZCByZXR1cm5pbmcgdmFyaWFudC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogVXdl
IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gLS0tDQpS
ZXZpZXdlZC1ieTogU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNv
bT4NCg==

