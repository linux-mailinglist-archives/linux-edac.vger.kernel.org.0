Return-Path: <linux-edac+bounces-4802-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA1B582B5
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D8A16957F
	for <lists+linux-edac@lfdr.de>; Mon, 15 Sep 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4A242D78;
	Mon, 15 Sep 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Ql8TxZp"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0672080C8;
	Mon, 15 Sep 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955871; cv=fail; b=JhBXj2Zzfu7+irGck5mz5jv17pqYb7KgeRoOzIriXoZXKEnxLTdmC0acvzE5QEPQxY/mUEup8jxKj3zqFAWf64YOPeWJ2rdn3w2RQ8sW9DZZJjbfH41T6LJwkVg7iR1CuUQ6Ic3Lj8EUmuPUBdio4qRtWTIhfianBvAxMlu5NUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955871; c=relaxed/simple;
	bh=E5Xml0JDLS+kcMOZRw5gMjpNUAD3Hd2NDuzzFuTQEQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HmC0RSz6ZS4tgjvk8zfGD7O+BHAHtTEoaIlqbrlBSImVazz75+bpCpA/+NaL8dxYCFplONiba2cBFW5Havgh6sTqtfrnXDNgCHR/BT67EGEjBZLswl8AkyPxQbb30moSJN3LuwbSJ2GTvWCX5BDofne/xeQwb4GDgd3wepR6orA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Ql8TxZp; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFOU5RGaSAFud6An+S591gbU7KR4Fup5UONvxUjh2KdSuvkoPVDgtfAOfRRLouZcNMaU9XTfHTyqTIJ9Kv5XwBiRvsSw62+A0VtX57nut/QaGsSM6xLUZfbQKYVS/s5tqc27k5rhi6fGQwQZuwuYi2yNujVvMLzsNq4Kg9t8SZsRSdGFTfgFQrS9R/sHGxjtuG6gsToGyFZGRG29k4PAzxPuGxKsqp64FHUerNC1PSGAMPuSdXTTyYV+OW4wGgPK/7u14lJA3n3JXEPN+pmSMYOybTxGKNO7UBK5DPygKPTSVcwDVo3EyTR6MqUTZoUXZiAZgq6CkfCsYfnFWC8Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2rXa1lrKKwcmOlsws9+x8St1Xr8tQRQHhMmE1V8sDo=;
 b=m0QE9J1BecSQxfMKIdnVkUYLffzuwiyuU/GyTTWEkbFbJWs/UV6n8lTx6zrGNYo2hvYZhgAvyIL/7+CynvAeP2BxOHh+YnilY1lDn+8wvd8klXEgb68dFMNLbG+IyS9L1xhvpqB9Tt/kWwj6zpfrSh84stt1uHd6eqToC1fE71QyOWeRXN+dxwUaiuIRMf/EsVI7OzWFCK3MXeaEcWQqENz/SbVRSr6BvyQtbb+gcps+8n0zCb/1OGWv+/nwFulH9UIJLjqYBPtnU8cFJVZACc6znwuJLdNTlC3MOpS345Zh5poipwXNFQC6l0+gLTo/cbc5Tfs6d3qcWQJMhfr4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2rXa1lrKKwcmOlsws9+x8St1Xr8tQRQHhMmE1V8sDo=;
 b=1Ql8TxZpn5Fm4OfYvXzwtif1S7S29UoenwD1T/ro+sRzct9pBJ3yHYL94s2KDXl3Hm6zPWG0vlSmyzKFIHi6VXlMr0SQpoBa/WiDGbgyasyThFgvRf5A09iUnadSpZkxHt2GMKt9uAL95JdkKetQbvrX6tBLy6n0vVGxKtMZqk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 17:04:25 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 17:04:25 +0000
Date: Mon, 15 Sep 2025 13:04:20 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
	bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] EDAC/mc_sysfs: Begin deprecating legacy sysfs
 EDAC interface
Message-ID: <20250915170420.GA850348@yaz-khff2.amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-6-avadhut.naik@amd.com>
 <20250910152427.GH11602@yaz-khff2.amd.com>
 <ba326dbd-5216-4294-b645-c4ff2a2f6578@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba326dbd-5216-4294-b645-c4ff2a2f6578@amd.com>
X-ClientProxiedBy: BN9PR03CA0695.namprd03.prod.outlook.com
 (2603:10b6:408:ef::10) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d16858-cd50-4417-78c4-08ddf479ec36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gNDdABjA1bwSlmNwuO8XNy6V8aAcNy8ny29C9JMuEbNA7bbamSWIHtPhsbZ?=
 =?us-ascii?Q?xKbuwHfC2PcWFY4GZClzA4xDI5rVAtTYqMyAduYrdfr6WTaTz7gvc4YcVHCX?=
 =?us-ascii?Q?ElGPMtSMUNgK3QTE1kfrhp+JPNlWNOP22tgyVxqnjWQ4DewieC3eWgK7NHqv?=
 =?us-ascii?Q?QzhAqEhg9QwZxFwkCgQorhYO5CVgNAhj9l7omH/TQe2bjwrzDR+CDZ9HUAc2?=
 =?us-ascii?Q?tMVEa8pVHBwqTKIXOH4qQSf5co1xdPZkbavfxmWcsmLQfc6WtInel9zRuN17?=
 =?us-ascii?Q?YoS2ph8B46qu7bVYjZKMD3SAQO0Oks8bgox5jpBW7ph5lnr/DXoVmhbGVe30?=
 =?us-ascii?Q?nnJscDz6OP0eoSMGk8p6FAtjJRPTH7E1K6RnQO2+TTnQa9hQ2CiKDcw9zp2q?=
 =?us-ascii?Q?voEYgcnXsiLTIZ2pbS0Xte3kYVtB6hCAqlKMbEOnK/BvnNbxsiO+5sJT5aFC?=
 =?us-ascii?Q?hB+l9HU6voFYG0WWKT+GHBdFfk8zbqkGMfK0qN6AGqQ5HoLgUruou4J0npuD?=
 =?us-ascii?Q?NcSMxFH1Xx1TJM2zIYnWFjJqgdXxJUHT7QHAFug92SiYGkHoyOMuNerhlCQT?=
 =?us-ascii?Q?OfYy0123gBlwMhmA7OrfcgUduk4KtyF/sQucsfV9JHHtNrN3//ISCyKuCkoz?=
 =?us-ascii?Q?GHwmYdHPIGGjVpw/d4brs4oa9m3at0HFwEqaxsLaIpYB+QbE7sDOpz108nyx?=
 =?us-ascii?Q?lDf9qwKEKcXHAHHC37sq+2lFKrytmfc0sQCJttTjbEIQaK5/MukFC3xlvqc/?=
 =?us-ascii?Q?Qnm1e2P2rLXxNwlZtlFSvP4xfP7I0A/lVwJJo4VkMRfWKsZGTiduzbD2/mIx?=
 =?us-ascii?Q?KxXPqY3dIncu645rokqQ4J6FNf2jXKgAKIYwKMb752Ykbdm4KR47eL2XF5Hx?=
 =?us-ascii?Q?WHnTF4khTWPwJBNSkk9/FIRiPn+9wrYtaSb2+vPUmEBae9FGzcfk7NrhIqkq?=
 =?us-ascii?Q?SjkTRVT0gq38i+qbfwCfngM/bRLt204qAEEZji7FF2UxUOnxLX15H3Jtg9+T?=
 =?us-ascii?Q?7AiG6Rt/lN9lZq5vluZ7VmQ3kI7ArZGQtl7j+4p/CakWRvYgtYMu0zZ1yguF?=
 =?us-ascii?Q?IBz9R8u4JXQJsM5xdvarVXxcMybClUCbBUlarKQ08mu4UEURnPYMDeNR81AL?=
 =?us-ascii?Q?mDlsKt9FtuLbzQqZIuhqNQJUoPpeaglKLhR21twfOLUzdaZzBvbbvnC3oWLu?=
 =?us-ascii?Q?ndE1v5Zrtmf678NSmC8EXpkNQj4tJICOmjhVcFnnwMACQZdFB3A/6/zNJdB6?=
 =?us-ascii?Q?7m6Iv4qo4imkofE7zJgBAx1EtprZah/BrKTW6GpBsXYqxuc80MHchaOZrj5+?=
 =?us-ascii?Q?/WC+smi5JleDHzZXxiVXZL4Y5jSyL8Eaz7OfVpnR/SIOqOms2KKN39hEBWT2?=
 =?us-ascii?Q?kByN4kEqdL/doKLaLWZZO60rwHF61/ZXtZ2jMt7Ns1jytB9U7HbySVtIKqPX?=
 =?us-ascii?Q?W0MBpWI5s1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ix1yGmJjBzDt281TfjJ9ZPySyH/52JkS1rVl7WOXPtQwrp9KSyBkk5s8wts1?=
 =?us-ascii?Q?4J7DOvUZDCD9bf03rrQcjLuAUK/+lwvN79mbuvVZ1S6y72L8FlGiYR7aJO3H?=
 =?us-ascii?Q?rZCF9eiagMqPA1TExTFfEHkJswvIcdRJ/gIgk3qz+PrDNx+pcXpGWY60Qs3z?=
 =?us-ascii?Q?dKn1kX3/woFrN1qlYYuY84HNhRj936sz6FEntEZ5O02IzYSOwtvXdYsFvJL9?=
 =?us-ascii?Q?Mig+hILZZ87uzEdPt6aTFnoZlDN4W6PROfxuhxQ/Ln/2WbgaSQFvwK98JRSl?=
 =?us-ascii?Q?Gn775INhwRhvfmFxR1/HCcYOUzaJ3QyAuiaJH0Uy44tnDpK/WKy6XPP43Djx?=
 =?us-ascii?Q?mXMa9/iPmURnBocpHGhjD5uISGPn/Dq6PdrGHCZnmNm6ydDrkJ8sOXQula4f?=
 =?us-ascii?Q?N0W2fT3SSTMVM5s+wRZncNYMHwYeIsvIYPDVotdnbbFw6tjzw6pFqa6A7GJ5?=
 =?us-ascii?Q?zSJ8+obpoH6Gb5Rs/H+tlmucW8EwosN8hf9K9B0V5l6J2+T9dQYUVPG/8SaO?=
 =?us-ascii?Q?gGOK2WAumKyBdE8fGnzEv2Q4nSuiXfyvYvzJHOjwWp8fZu+sUZVJSsch77D1?=
 =?us-ascii?Q?4T7ZHVIrUStduz+1+luJVKeOApLJD4W2n6CBf0v7bqtIOZYdEmTgeKDZjUvE?=
 =?us-ascii?Q?X2m+kUGVWh4qgBEkZ3hGUrmOI6qn8+D9J24IQnAdurdEQXaPresmRY1xp9Lg?=
 =?us-ascii?Q?m2lUDQUJljIhCaQ0Do5AW7IcrgP37Xz++42r6d8QEUncsXlmARinfncUapiR?=
 =?us-ascii?Q?EgMm1KmJO7YRqPwDj0OsTUFny6rhW0vwSREVg6eiockUxFY2y0/nwFopu4Ee?=
 =?us-ascii?Q?Fa0ePHyOpEJOu9qYArBKBAOhKoMFTpzirdGdtzuo1o1Q3lVMpc9EaDQvwBVH?=
 =?us-ascii?Q?22t08hJS92vz8YIBK4b74491Kuj81qrm2OdDS686ZNPf5R4O9xU9GlzFhdMB?=
 =?us-ascii?Q?bkLvA6RkiS+r2r6F8vYetkB4b5mwoEzdV5gjC3ZyvpyyavUGDS8HyslYkpzU?=
 =?us-ascii?Q?/DFdB3yEtiNRFvx0uyn6jf4ayUhxWV3KNDZ4+11eboQhzLDGixNZ6wUr3fHi?=
 =?us-ascii?Q?+4xcv5NONGu/UK4IAdLqxpbwMoewGNdD6Az7NW32jNZTnjT4IFMIm9g5zGmL?=
 =?us-ascii?Q?V+tgQ/RWsVKJq6D2WdBQ/ggtqDqB1+LzYGD/SQicfx+Zyx6DL8a9od1vlSUm?=
 =?us-ascii?Q?e2qVP7QElfHGnHkkhJlufBsw/D2qG23kYzH8j2NdxvtPXcXd5bYOWR+Iuyks?=
 =?us-ascii?Q?D6o0io1TqZb0Wg5PbQiAP8GUyMwd2+0PMo7IhQyMv8VGo90xideHVM0cKTnN?=
 =?us-ascii?Q?Rm+IhRp38hAIDK4KHd0U6Kdv7by5LZ/C3r2RYTwBAgny9g3pGvT3xfZ+JNUt?=
 =?us-ascii?Q?SR9DMoG5ugAM0TwqQ7bTfG9rDBOMVI1AqmCErrWSkJ/p1OcCtJLolxbj3gM2?=
 =?us-ascii?Q?ywGShezPuZPne/0lqnpqL0QsJxSphsTn9PTDNuS0HIvMdpIG3grQhhCeoKCi?=
 =?us-ascii?Q?GSZUWlGrXERZaza0Z/6WgNxwazYiFA8QGds44u6YqM3HMSXxgd8oMD9hmX62?=
 =?us-ascii?Q?VsnZMIm6LH/L+TL5RTzoeuBWX8fYoHLf0+fiVR2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d16858-cd50-4417-78c4-08ddf479ec36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:04:25.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kzdq3wP4EPioKU5YfV2xgPbScGJ967AtiONntDJ/QKCucwi+uaalybHRKVDhz6mD8mufFl5sMOfNSwYzub2p3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

On Wed, Sep 10, 2025 at 12:38:44PM -0500, Naik, Avadhut wrote:

[...]
> > And maybe the warning can go in an short inline function? Sorry, I
> > forgot if this came up already.
> > 
> > Also, "two future releases" is vague. And it may be confusing if this is
> > backported.
> >
> > Does anyone have a better suggestion, or is this good as-is?
> >
> 
> How about explicitly stating a release?
> 6.20, for example.
>  

I think that may be okay, but I'm not sure.

Boris, what do you think?

Thanks,
Yazen

