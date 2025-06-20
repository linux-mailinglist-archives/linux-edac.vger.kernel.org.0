Return-Path: <linux-edac+bounces-4195-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00AFAE1982
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jun 2025 13:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD91BC7901
	for <lists+linux-edac@lfdr.de>; Fri, 20 Jun 2025 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6028A3E4;
	Fri, 20 Jun 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXrN6qUJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9828A1E0;
	Fri, 20 Jun 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417390; cv=fail; b=pPQNgXsgu4+33VXjC3sS3kTkhPIzSv5WjLYdWuowtGjFqtleEw7WtGdfkKkKFZ9XhmnfrMPYrL+WHwdnVeuju0IfLjDYokKEWG1p+ZdzOpDyX9PNTH4CUzP+Jtc63l2Wi+Im6Pvs7Nt3xXsu2m05sz3wgOyqPOjH2uXTY6KTVWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417390; c=relaxed/simple;
	bh=DlmYmk5d9eS2b3pEWebEYzsfujebR88laMU+HRXT1cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZC8nQXlezew+ht7S6t6yF8Uq+GSEzJRt5n2MytfOOR7bYgKkbehIcya4ViHTN3E/9mCld9RCBQTRK9ZnoU+B6fsVWPofWcBEyU79MdqERuHYzYq4OkXsjfdG9kDRjjKYuGvfqOu6+EawJzUjd2VD+eY9w81yYadRmNlH2fRcfKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXrN6qUJ; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf4M/kp14Lscf40j96yzCm2m9tI53gVh4C2nngNvjDY2RutSVc6KvSZd4ONv6pAfDbfU3Azp4SHcD4GWAl4vJMFMRzXe0hXXmaFvT6xjQ2TThjUU7cHEisDLQZSDSpiRlYDcTn4M7B5FY9toEtbStNDCvMcRA9+2TM+Efsv5JlAp+HHOXthynlSgrWL27yPlQ+zaf1V7B+G19HSCRLVvdPckmxQ6lt/iDBOUg1YAwAgHlOGD4FKtZo0HHN7pj0KT/u1mg1elfo4aiI3eMnYlEUCjbhqGQJlR6RRjPNCNCE8JoywNeyyYkX7Hm3aIYQUrAh99TnoagQg5PYjcuci9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E00iS1glP9o0LQG+u9OmcX1atw/3vlCtxs4EfNDbj2Y=;
 b=Lho9nl+NipBOaz5Gw8AJQ+x5dHEGZ1j/AnX/59wVGxoSb4JElCHjQEJtW64VQiR/5235abGhqAvsS9TL5X9JLAjwjOYuvaa4BI8XP//V5W2CLXf1DWI7UWOrkGXeNxbeYrw+RVEwvL08RKhmUDsP53gMxcHGmuNZz9j6lBPhRHlOfV3jynRf12lML2pkugunRvz7y9PbvMhV4pWa11oeMfEHQEtjrgjxDm2UljKzFtlH45330/wXezH2bmpMvRxPXauQgZ2tbAkUwAvF9D4d2Jsh6Sz9crxoPhiOJDIxxRLG65zaKBjXNmRGy8m/bAYAKCXppj8/f79kEAXU/6yRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E00iS1glP9o0LQG+u9OmcX1atw/3vlCtxs4EfNDbj2Y=;
 b=mXrN6qUJ79XRGxpDsDJaaGMh617rT4G1YCcQ1mEHXrN+ZBjDm3aMtcA8y0SmD+CtbwUViNumMsRe9tLdaTmtCOEbfxea6Y9NyF1stFfD8esbhQU4yltuXyMGufMBiROmeDYm4iENiWYnJGHNuuZlYhqEyQaT465tfkdySOhOO4I=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Fri, 20 Jun 2025 11:03:02 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 11:03:02 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "git (AMD-Xilinx)"
	<git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>, "Gupta, Nipun" <Nipun.Gupta@amd.com>, "Agarwal,
 Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Thread-Topic: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Thread-Index: AQHb0Gdq2gBD2sbZ202dCMp7SzlQC7QBnaEAgAQzPnCABjAVoA==
Date: Fri, 20 Jun 2025 11:03:02 +0000
Message-ID:
 <SA1PR12MB8947279143D868E39D30F616817CA@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
 <20250613201034.GC171759@yaz-khff2.amd.com>
 <SA1PR12MB89474C0C76A66775B91A20C98170A@SA1PR12MB8947.namprd12.prod.outlook.com>
In-Reply-To:
 <SA1PR12MB89474C0C76A66775B91A20C98170A@SA1PR12MB8947.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T12:19:00.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|DM3PR12MB9435:EE_
x-ms-office365-filtering-correlation-id: f521bebd-da50-4550-5ad6-08ddafea06ba
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RpBm3ggRBaWUXvBbISYpifatVoKQ9rYJJEBtpmLllv06PeG0j2omKH3Qlvhp?=
 =?us-ascii?Q?AM8tArHHWx/5v3Y6Zcmc5XVYIzkhiBL1ycwaK6tJUeLLTNlBrjGNOjVhKhhR?=
 =?us-ascii?Q?MaS7Ef7YvtCgiB1uEOvrF1jwDmfhk6uptIenMno1Nm6xzsttWV1vePuse8QE?=
 =?us-ascii?Q?mNB7It7LtjlkV2RIfKYyptG4C8dfZYN4aIL2PI0O28IUwRlel3yPcHmxai06?=
 =?us-ascii?Q?dDWxKiMvu4KKx1f4mTC26yt2wh5fkjFnzQxnQLQGhrJDpGXBZH9+hnoKexYt?=
 =?us-ascii?Q?BZfiDE6gw4S2TSiGeWLM5GuWtXx9vSiqt+HYPzm9GII1ryeW6IbS6Tt/1M9m?=
 =?us-ascii?Q?sWmlJDP+q1sSy68Xo+osptHXIsWIAUpJMmIVECtP2HDTzI9LmnG6QCMI2mTZ?=
 =?us-ascii?Q?zyHlgolhZegde8R8fGZ2ZJIXjEKO+eeOZJRiPBdC/FYyXfHTGja0dVsPe75u?=
 =?us-ascii?Q?P3ARd96vMIHkoLLcDbalpPBI0o83kUvbRqgmKb7oGwNFxRWQgkUlrpvwvTWJ?=
 =?us-ascii?Q?YPjQvKKD+4D0ZG1Kq6jvO76VLn4cBxuHOLT2SUTZ6c6PZWwSHLjsfUs5qE+3?=
 =?us-ascii?Q?w+MfWwrv3MSCbwBjnsdV1jvDcH83RCaDK3VwFn/meHCYyS+3VaApK06P7Y8x?=
 =?us-ascii?Q?/JPp1YAM1bAXJkWXkUHv/xc+u11wni9y+kwkhqPMN35miS3PY8g0lwtXmmp9?=
 =?us-ascii?Q?N06jzoCbClz64pq5pcRGTxa4GzHj6U+ouRDkT3+oJcwkYNo6b0Lj/0CVrIJ1?=
 =?us-ascii?Q?GAPjHMCdrwuEAEv0pn/9l5w1mYDin2Jcjc3CnKwu3HLE4/DQT6I6CeBfSvzS?=
 =?us-ascii?Q?5ciwm2oiFawwbGGThcWfiM9ygPWMw9v6S7j5o8Fr0vqdeO39y45GxeGjosT+?=
 =?us-ascii?Q?NurAuBowrow5BAop6LuyfzNu1/OiYodnDZMbuOVk8wR/u8bVeJkszxRZzSDK?=
 =?us-ascii?Q?1FLu0FBhecRBCVuCFwhkK+THLQbgM5LnNgBxMNfklgn2kd6yFA5EUsn6JV1o?=
 =?us-ascii?Q?tjAvG1u/1nrImp2fN47frsDdpWllv4toVZ+5eU5DObyIxVFTTKAhHROhCEov?=
 =?us-ascii?Q?hSksppGQGDRQn31ewhBKYDhxZvBVOe+aYIGNjJRDntY1QOpUM1uCR3BWLXky?=
 =?us-ascii?Q?0UWBktsFlk8bXELQOZCs//1VCe6PLWwRVY0u8iT2iD3er1dRxsS0CdhBvi2Y?=
 =?us-ascii?Q?ruEwYDer25PSWPNKjDpUtAdKu7oFpNPqrLIR0Hz1SPnbIUuk8Y7VY8neIH+/?=
 =?us-ascii?Q?CzhhHTc9F7Qmy5rjBWcDDUxjDaxtQnR32nK2UWJZAJn1e7LNL9XKvQEiMD9b?=
 =?us-ascii?Q?LfAMeN+q+sh35COj+ARW/ts1GjE6hgMuaX4TluyeHJzySmxsqhH/vqqFjTGP?=
 =?us-ascii?Q?/kArGQBKgxFSU45V8vLGri3tl5OyinusU2N8YRwE463VLGRPkQdjVHihMJ8y?=
 =?us-ascii?Q?xG3qtl77khnS/SamfheqsBUoaNmnljmCo1dL8skFQjwMNHxojVGoLfNCPss6?=
 =?us-ascii?Q?ZJ/97NiGyFM7L9I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jByfezdV9hMR8xPByNuh3R9palCgeTA3QLnQb8PX+rrXndB2t5uO9QmB+lsT?=
 =?us-ascii?Q?tJzSpFDgwOSPdqCGNM7no3/gKUzpQUPF26i1kwv2f0zvygfA7y6UaEkL753L?=
 =?us-ascii?Q?BWQrdAd7rtJLM4Fr0UqsYR9egeRL9tfT3vqNXs1HasWt3dpdj32X+6Vuj2Xn?=
 =?us-ascii?Q?R/4yn33t2wx3GkK7kKQ7rhAgLhx1IYxzJjXOxtL/albOy2vSogRoFGK4sJAD?=
 =?us-ascii?Q?p5GYKUYK61YN5B9Xi+xS3pWToLaQAKEXvfyoUinZLos7/H+FfNQiWwyHPwvk?=
 =?us-ascii?Q?1Lf2BqnAqr22cKjdqrN3VZ5PB/8yW4PbS7JjO1o3NbnTfZamSSClgIiMO3PT?=
 =?us-ascii?Q?60Z54i2x14cQ1/ssosk+yZNlzJrsl/X2dMiQQ8daPhLxUXiOTRYOYKkaMuqx?=
 =?us-ascii?Q?yCSa22EKgbPZkg3JevUuthTlhbE+Ldjsn9HVqbxI6mFT7GYOdzWUhmUAP9v1?=
 =?us-ascii?Q?r5YnScSvROLnEQQYATSL0ng6lViaBsb3+dDMijlxq6kkOkXR+eMQwGjwiBax?=
 =?us-ascii?Q?IVIN8T92OP9i7GND9k43Gg7qhxZ5cBFB8djxcFJt/aUYFxSYCVBJbn5IIaJU?=
 =?us-ascii?Q?OM/YUOaKR3q/5kB+a/RvukJIHgTwdoWMY4npKQeYiurBUBR+khI4pM0+LFVO?=
 =?us-ascii?Q?I3wgX5Hrf8vZfU3oqegY0tYUWUE43bHUfAXC27E4LtPxV1jS65BY6ottVrcl?=
 =?us-ascii?Q?513o0vCGegoHyMjGy5B0toN8Ms08fJjlPgiSA/yljTIrCXjugtV4ItczCDcF?=
 =?us-ascii?Q?Dn1PwgqLYaaYWYeKoPL5MBAoEjTP0XANELVMGZBGMrM2ZZy8AloK6yc2Fmre?=
 =?us-ascii?Q?PmuFQBIEoKMnnTgO82/io5WqaYJHm4pyoArUpPemEOqht7cmqJQc92cOPgds?=
 =?us-ascii?Q?iwwmj8BXn0pEUB1YJUDejEFrfynokiE/gDlTls3195RYSfHd5AJdIkmTeBIJ?=
 =?us-ascii?Q?UtLbjaqqIrZjGEUXXmHvVHUzvaoMO/lm/perJqSlZv/9dpU6IAA1G2NsdmH5?=
 =?us-ascii?Q?deqWtTafxrfKJqg+XnTzgwP6+mSHx26OC9yETuIrOwvOcS/U4MS7HSZ+nSit?=
 =?us-ascii?Q?jTJmVKI1qZ3BBy8g19UvImNLudLQlTkl4uvttvtoZ2rspATvjEk2jhyb9cF9?=
 =?us-ascii?Q?vvKslv9YtN7eSvAFpfsWPMS0cNEpFQzz3+wLPvpmfBuu1t69qEZI0SuWUmqh?=
 =?us-ascii?Q?0DK3UKvb06PsoGshWgwyG1l5Wz99LG4TkAT3FWyGPC/y5W/j0qBRp3lyEc6c?=
 =?us-ascii?Q?mc7Xvx4fB6qcDuA/+8hmspnYGzQCyPKmMH6J8o5NadDOEWFgZIPlyogWq6b2?=
 =?us-ascii?Q?8yb7z89lZr3kxYow+cRFRMl5ex2w9ohHF+JhNbodLEuDg3do8UBCM+OaK1/n?=
 =?us-ascii?Q?0+0cHZNjCrV63T954vKuHpyycKmJBhPu3qWsCJq9xLkOdU2/nT8boGc6suPX?=
 =?us-ascii?Q?ml3vXnmu1QtKqhDz2zfMn/MYOYkqsJxLZHn64Lj3hIH7mZr+A/aiYvQlJfhY?=
 =?us-ascii?Q?yipP6qIGt6s143kEuo3+oqjw3oXFwO3fYl3WGyjOa24LDPch2QCqBu6LLP9/?=
 =?us-ascii?Q?PbmZc9us4yUlFx+VRs0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f521bebd-da50-4550-5ad6-08ddafea06ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 11:03:02.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN0wKUCebWofeCR9pjhIWqWQbEL79Bgl0bTVXLlqkDoEedLBcwLDE6rnF6w5t0myDsswWALMKHxDMeLDM2M5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Datta, Shubhrajyoti
> Sent: Monday, June 16, 2025 5:51 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> edac@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Krzysztof Kozlowski
> <krzk@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Borislav Petkov <bp@alien8.de>; Tony Luck
> <tony.luck@intel.com>; James Morse <james.morse@arm.com>; Mauro
> Carvalho Chehab <mchehab@kernel.org>; Robert Richter <rric@kernel.org>;
> Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> <nikhil.agarwal@amd.com>
> Subject: RE: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and Initiali=
zation
>
>
>
> > -----Original Message-----
> > From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> > Sent: Saturday, June 14, 2025 1:41 AM
> > To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>
> > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > edac@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Krzysztof
> > Kozlowski <krzk@kernel.org>; Rob Herring <robh@kernel.org>; Conor
> > Dooley <conor+dt@kernel.org>; Borislav Petkov <bp@alien8.de>; Tony
> > Luck <tony.luck@intel.com>; James Morse <james.morse@arm.com>; Mauro
> > Carvalho Chehab <mchehab@kernel.org>; Robert Richter
> > <rric@kernel.org>; Gupta, Nipun <Nipun.Gupta@amd.com>; Agarwal, Nikhil
> > <nikhil.agarwal@amd.com>
> > Subject: Re: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
> > Initialization
> >
> > On Thu, May 29, 2025 at 12:30:14PM +0530, Shubhrajyoti Datta wrote:
> > > The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions
> > > are needed by VersalNET EDAC modules that interact with the MCDI
> > > (Management Controller Direct Interface) framework. These functions
> > > facilitate communication between different hardware components by
> > > enabling command execution and status management.
> > >
> > > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> > > ---
> > >
> > > Changes in v7:
> > > - Add the kernel doc description
> > > - Add the prototype from first patch to here
> > >
> > > Changes in v6:
> > > - Update commit description
> > >
> > > Changes in v2:
> > > - Export the symbols for module compilation
> > >
> > >  drivers/cdx/controller/mcdi.c | 29 +++++++++++++++++++++++++++++
> > >  include/linux/cdx/mcdi.h      |  6 ++++++
> >
> > You've added the function prototypes to this new global header.
> >
> > But you didn't remove them from the local header.
> >   drivers/cdx/controller/mcdi.h
> >
> > Also, you haven't included the new global header in the cdx/controller =
code.
> >
> > Even though this does compile, it doesn't seem proper.
> >
> > I expect you would want to do the following:
> >
> > 1) Add the common code to the global header.
> > 2) Remove the common code from the local header.
> > 3) Include the global header everywhere the common code is needed.
> >
> > Keeping the diff below for reference.
>

I plan to have the current (in the cdx) mcdi.h to mcdid.h and move the comm=
on parts to
Include/linux/cdx/mcdi.h

And for the bitfield.h will move to include/linux/cdx/bitfield.h as most of=
 it is needed
by others


I plan to rename the existing mcdi.h under cdx/controller/ to mcdid.h.
The common prototypes and definitions will be moved to the new global heade=
r at
include/linux/cdx/mcdi.h.

I am using most of (close to 90/95 percent) the bitfield.h, I'll move it to=
 include/linux/cdx/bitfield.h to
 make it accessible for other subsystems.

Let me know if that sounds good.
>
> >
> > Thanks,
> > Yazen
> >
> > >  2 files changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/cdx/controller/mcdi.c
> > > b/drivers/cdx/controller/mcdi.c index e760f8d347cc..f3cca4c884ff
> > > 100644
> > > --- a/drivers/cdx/controller/mcdi.c
> > > +++ b/drivers/cdx/controller/mcdi.c
> > > @@ -99,6 +99,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct
> > cdx_mcdi *cdx, unsigned int cmd
> > >           return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);  }
> > >
> > > +/**
> > > + * cdx_mcdi_init - Initialize MCDI (Management Controller Driver
> > > +Interface) state
> > > + * @cdx: NIC through which to issue the command
> > > + *
> > > + * This function allocates and initializes internal MCDI structures
> > > +and resources
> > > + * for the CDX device, including the workqueue, locking primitives,
> > > +and command
> > > + * tracking mechanisms. It sets the initial operating mode and
> > > +prepares the device
> > > + * for MCDI operations.
> > > + *
> > > + * Return:
> > > + * * 0        - on success
> > > + * * -ENOMEM  - if memory allocation or workqueue creation fails
> > > +*/
> > >  int cdx_mcdi_init(struct cdx_mcdi *cdx)  {
> > >   struct cdx_mcdi_iface *mcdi;
> > > @@ -128,6 +141,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
> > >  fail:
> > >   return rc;
> > >  }
> > > +EXPORT_SYMBOL_GPL(cdx_mcdi_init);
> > >
> > >  void cdx_mcdi_finish(struct cdx_mcdi *cdx)  { @@ -553,6 +567,19 @@
> > > static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
> > >                   cdx_mcdi_cmd_start_or_queue(mcdi, cmd);  }
> > >
> > > +/**
> > > + * cdx_mcdi_process_cmd - Process an incoming MCDI response
> > > + * @cdx: NIC through which to issue the command
> > > + * @outbuf:  Pointer to the response buffer received from the
> > > +management
> > controller
> > > + * @len:     Length of the response buffer in bytes
> > > + *
> > > + * This function handles a response from the management controller.
> > > +It locates the
> > > + * corresponding command using the sequence number embedded in the
> > > +header,
> > > + * completes the command if it is still pending, and initiates any
> > > +necessary
> > cleanup.
> > > + *
> > > + * The function assumes that the response buffer is well-formed and
> > > +at least one
> > > + * dword in size.
> > > + */
> > >  void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword
> > > *outbuf, int len)  {
> > >   struct cdx_mcdi_iface *mcdi;
> > > @@ -590,6 +617,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx,
> > > struct cdx_dword *outbuf, int le
> > >
> > >   cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);  }
> > > +EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
> > >
> > >  static void cdx_mcdi_cmd_work(struct work_struct *context)  { @@
> > > -757,6 +785,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int =
cmd,
> > >   return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
> > >                            outlen_actual, false);
> > >  }
> > > +EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
> > >
> > >  /**
> > >   * cdx_mcdi_rpc_async - Schedule an MCDI command to run
> > > asynchronously diff --git a/include/linux/cdx/mcdi.h
> > > b/include/linux/cdx/mcdi.h index 46e3f63b062a..1344119e9a2c 100644
> > > --- a/include/linux/cdx/mcdi.h
> > > +++ b/include/linux/cdx/mcdi.h
> > > @@ -169,6 +169,12 @@ struct cdx_mcdi_data {
> > >   u32 fn_flags;
> > >  };
> > >
> > > +int cdx_mcdi_init(struct cdx_mcdi *cdx); void
> > > +cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword
> > > +*outbuf, int len); int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned i=
nt cmd,
> > > +          const struct cdx_dword *inbuf, size_t inlen,
> > > +          struct cdx_dword *outbuf, size_t outlen, size_t *outlen_ac=
tual);
> > > +
> > >  /*
> > >   * We expect that 16- and 32-bit fields in MCDI requests and respons=
es
> > >   * are appropriately aligned, but 64-bit fields are only
> > > --
> > > 2.34.1
> > >

