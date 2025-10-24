Return-Path: <linux-edac+bounces-5187-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C67C07AFF
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA440162A
	for <lists+linux-edac@lfdr.de>; Fri, 24 Oct 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B1346E7D;
	Fri, 24 Oct 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TseXtK2/"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022101.outbound.protection.outlook.com [52.101.53.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C9254B19;
	Fri, 24 Oct 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329623; cv=fail; b=E7RKAXI20oOpk6qT8MgXtRyLe25AW/aLfNbTnKIlhJ/prDrxFOjeofvlD0waQxO2V2zLjRFK0/352toicrOnck/sGOESpl5uiledhQWllYUKPnOVP50VoFaXNbjKQLpZR1zXOdwZRp6Re1T1kO04S5T26PfvHv8ME7QQxTjebPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329623; c=relaxed/simple;
	bh=nInQG/cQ3iwY1xBnSIrbK55aUnIHOUZedwL2hZdGV5Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ne0GnFstQnYUavPZ6nfVCX8HKI/KDTZvcPJBM69OubvQgVyvejxgp0lHZyc4i67z0bmu0eauj1lDVIv1FPPlCMwYzIP9fJFqcDJFuNEbXwax1EB1cRc9t83itbps7jGp59VPiNQpXtxOjbqKKt3aiuTYRlBFBry7r3UV4K2DqbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TseXtK2/; arc=fail smtp.client-ip=52.101.53.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+9y75z2UluiDTeV8yf0bkljTUGUKDytw04MHlkfQf9a/kiAqoSKgmo9CBC4nAYX9NoTgwBSuGsKcvK1oL3HPmluh0EgpxF+MjybX4Ss16ShDBnQlpzcj92fX7zrlsDQqKvK5S3pIPYrdPjvW+Lc42KjtP1qnjUJtEXVFfPLOfMzIsygIzz87XOXsGsWEdtr2t9dKFm+xWEOUtQQe2tTt0vfnhOi+0UCcZorO384z1RofkSUDmUruGZXU/txsjQxx/eCDLpXawPDYrixJ1HjoOLfSfsRz8mmbaMyph5o8BlvD/n5ba6JfTaxVMNUf09Y64uK2XXJCa0cBgp/VuHLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yERsSIi0cpAh6owSOhSXWXuF/GAFUfgyiami3sSq6E=;
 b=FMLkVbJdI/SaY3b4ut46gziPW7XIVAPOnWZ9tNOyZg/fi1p8llIQOl+GEYBtz/inNKaThvdkhUMh30U7ouXQ2gU+sn6zvNhR3jD9o9YsfMfusOvNAjBqCnAS7B5rnI+TROmh+s5nni3vVwGsWA82typi90jIO35JnqMH7VnW1KkSx1DlA4b3ebbWQWng0/6KD1qIJdYQ+xrsTu8Uwlfgyqqj4qO9FAqW5tQIE6BWgYuZzKQhQdCSKHJxnue19OJD/a5LnM1HEYtxP/oHxyHkyhmdyFXDcnLB/KKUCudd/6Sjen9Tvhq+ElyKha1uwwzDUbGinxDLoYbfaBZBiPTJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yERsSIi0cpAh6owSOhSXWXuF/GAFUfgyiami3sSq6E=;
 b=TseXtK2/2KxKBFoIBLwFxX+4vdaUAzdLa6jFe3vm1e/hEVvqS3h8UEPt6KKITARDCQsPSAHWbk60Slcv7XhChbnNUpea1gXJ3wGT6hyvh28UIwx7RIhgL+sU++0NCSiKowdtBR2fPHvYzEOuyogEsAQGoApxtiaZN/OT4zq39NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 PH0PR01MB7521.prod.exchangelabs.com (2603:10b6:510:f4::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Fri, 24 Oct 2025 18:13:37 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:13:37 +0000
Message-ID: <17bf7d25-df72-4807-ad3f-2e09a0d1084f@os.amperecomputing.com>
Date: Fri, 24 Oct 2025 11:13:32 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
To: Shiju Jose <shiju.jose@huawei.com>, Borislav Petkov <bp@alien8.de>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "duenwen@google.com" <duenwen@google.com>,
 "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
 <20250919103950.GCaM0y9r6R6b5jfx8z@fat_crate.local>
 <6ac4ad35975142df986bfcb27d1e9b2c@huawei.com>
 <20251015223242.GBaPAhCuS7YWqu-aH0@fat_crate.local>
 <75e9bae2d30748d5b66c288135915cc3@huawei.com>
Content-Language: en-US
In-Reply-To: <75e9bae2d30748d5b66c288135915cc3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|PH0PR01MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 4daaa23c-211a-483e-25c8-08de13290d30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzRBTGV4M2d1cFNERUtIb3hPSmZTYk9FbG4vOVZuZC93U2g3aXFsUjdDTTZm?=
 =?utf-8?B?cHF0YXFKVzVCeHR3TU5COU9COUFPK0phWSs2NFNOWG9WTXdrVUh2SEl2dyt3?=
 =?utf-8?B?ck9XREFTWGJ5ajFoeU5TdmI3WmZhd0FwdFRROVdjYnFJck1KRXUxbk5wWjFB?=
 =?utf-8?B?QnNjcjVzT1BQOFVHOFYwVjFrZUhhSkZXcUd0d1VURmkvWFNTVjZiYkFQeUhm?=
 =?utf-8?B?M2RTMnlSWmloYTd6L1gwVVdlVGQ4SlFNMXh6WDhpRjNZUzgwQzkxWkFVdWF6?=
 =?utf-8?B?aFprbFh0NkVIYjNhYVRRdEFsR3RKWHd3RndoV2hJMmtpVlNsQjJmNTZJbXk4?=
 =?utf-8?B?Y01rcVFNSkF6bEN0N3NxN0tJSzJoWnh2MGh3VEllWHZWYTd3MkRJdVNrWWd4?=
 =?utf-8?B?ZFhIanYyQlpnQWRzV2FSaGNMeWR1SXhCcWxzSm00Wi9uWEhUZWhZWDRPSkFj?=
 =?utf-8?B?ajdySk4vYzJHbjlOTXliL1dVNlBpSjRPbU1tOWwwd2ZOcXlHajNlYmhub1pE?=
 =?utf-8?B?YlBEZFhKRHB2NWFnVWlvYkloRHVYaXVpOGcvRFh2Vm95bFhxTnloRWhuLzlS?=
 =?utf-8?B?SjhlNWk5SUNHRGJsTFlrLzZLRnVQc25CdWZqYmNDWUxYcFpHek44VHdUOWpQ?=
 =?utf-8?B?TmphNXlMbGI3d1B6dnc0dkxhSFAvRkVZRWp1Zlp2WTAyZVVQVzA5ZjBJdlFZ?=
 =?utf-8?B?SFkxV2xUNnI4Wm41Vmpwb3ZOOG5UTU5KQjZRdzBYdnNobGkzVktSU0NhL2xW?=
 =?utf-8?B?REJYUDl3dG43ZUhYQmtqRE16WURRbXIxMjlxMWZTcjZUb2pKN0c4UFVDbmZt?=
 =?utf-8?B?d29nZzVUMkFoazV5YzVRcjNMS3VPNUQzRFJzZCt2eEZlVVFTL0R1YWNkVzVO?=
 =?utf-8?B?cDRUUmQxbHZJK1pzRi9RYUtPU0dMQUFPcmhIOHQ0QWpuaFBjSVhmWndjTUJ0?=
 =?utf-8?B?L2JMWlZhMlU3djMwbEhGb1p5M3lXT0tnWnkxYXpBRW9Fck93TWoxMDhzcktl?=
 =?utf-8?B?VXZmbmkyQkVwQlk0S0lxNmZ1Z25MTFFLdTNKQkExd2hVNk1ZOGU4aEJCbndz?=
 =?utf-8?B?OVB0R2tERXkvdHk0TVJMTURDb21yb0NxMkQ0bjQxcnJCQ3NlNVFQbzUvY3cr?=
 =?utf-8?B?VzB3RytQcENBNk40M2JtSXRsc1dHZU9CODhLZGJENzVCTnYvZ2RVM005L21X?=
 =?utf-8?B?UldyeGRGemlJMzJ4RnNBN21SMS9ST1UxcVVMV2k1M2kxY0lHNEZrOGFYYWpO?=
 =?utf-8?B?eE9oc3JnckxWSWhhNCtTL0RMY0kvQ0dJQWVqbmhta0taakdyTWpwWkJoNVJE?=
 =?utf-8?B?KzgySk52WFhndHc4eC9oWWVhM0dUNWhxdmxpZFBBMVFNdmx4d1VZcFZscGpr?=
 =?utf-8?B?Q1VRQjc5bDFWVnlpa3JtMnB6Qi9hM2xoY05YQlhrR0VsQnlrTnRQMFQvNC92?=
 =?utf-8?B?ZXFhMzhpbVNJNHlBQldUbGlGcGp2S00wdTJSb1R4Szk0TkRGMzZEYTBYVjNK?=
 =?utf-8?B?Y1llMlgrbFdqYnVRZ0JRMEhXMkNqQmxTMDJmTHhMbUQ1bGcrVmxSenFOaSs4?=
 =?utf-8?B?MTByUWpFdE5oNGtMZ1lncjBJbmxrMWZiTVNjRGZVL3dxVmNpR0VoVHZiS2Zl?=
 =?utf-8?B?dmYwRExpSUlkaW1vSERWVHBiMU05R290cWM1VlN1b0Q2K25XTzZ3QU56aERa?=
 =?utf-8?B?M2dUSVZOQ1QvR0tLY1c1bjdWUkQ0OG42TzIvNnFSTVJMYlRUUEQ4L1FPZmtH?=
 =?utf-8?B?cnAzU0FTL2tBQzN3eGlWZ1YrMnNyZTAwd2JPQm9vWmI2TWF2VTlSSzFoOGRl?=
 =?utf-8?B?bW9XSFovZUNublB4QllyUXJTVUhsdXM1VlFwMG1VRUc3UmQwbUdFS05aWE9j?=
 =?utf-8?B?Vm93Z1o5NXRCRzI2V05rdDlWNVJqNWlMZ1dRZ0phaFlyL3JNa2I4clpzaUlI?=
 =?utf-8?B?V0grVEJBRUN5SDJQTUJ6WWoweWVka05YYXo2WXFtc09RRFpWdkFiZUZSVWp6?=
 =?utf-8?B?cUxGNTczZERPU2VlWGEwWFBhMEt2c3VRNlBvbEtpQ3NvU0MwSlJpalRsSkRz?=
 =?utf-8?Q?adCzAQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1M0SlZycTg3VnBGVzhLZHR2d2FmZWpoK1I5MnlLYWpYQTQ2b3lsUUdHSk9G?=
 =?utf-8?B?RVFray9OMVcxdUVBUWc1bnVScEpRbTZLcW0vVmNab1lsZmM1UThjYWQyUHNv?=
 =?utf-8?B?dVRCOE5yanYrRlljSmMvYkVyMUgvZmxyNUlQb3JNcnlPMXh0NG1pYmM3SjhP?=
 =?utf-8?B?TGVnblhtMkpRRjJPdVhreURGd3BCOXBNWG5PSHA4QmEwQVYyTXBsZHBFN1Bi?=
 =?utf-8?B?TW5TcmNHUHlQdEQ0UzZsNDNQR09xTlQ5SkM5ZWc5SmwvYnBxWHdOME1SSFNW?=
 =?utf-8?B?SjMxUnRRUTNsTjIwZWl0U0REd1IyRzZSNzVCaHNNY3lqVGI5V0taaVVzWUNM?=
 =?utf-8?B?c3FhWCtoNTdOWkVtQVlRaGVMQzM2d0Zjd1djMUc5LzBySTlDemJpcXp5U0VE?=
 =?utf-8?B?U2ZWcXVlc29QYk1rZzh1VWN4WWJXc051VUd4bjBDbk9OV1B6ZXN5RVJHaHUw?=
 =?utf-8?B?OWhmVDZtTnFsVW5Xa09RY3R4b3o1SUhzQWxKRytPMnpwYVVwUzE1cXoySGt1?=
 =?utf-8?B?Z0FlUERxZE4ycHdocVdqUnZtSjdBUjRrMmoxMHo3bk0ySHR2eFBVRWJ3SDcv?=
 =?utf-8?B?SUtXaXQ3ZEpKb0VQRENNUEo3UkhoR3JhcEM4WXNXZGNGUmFOU3phZ3lERVls?=
 =?utf-8?B?TDRRbjEvUnJWT1RDSkZxckhZRGwyam1iMFE5UFBGa1Q5dzVOS09kZmQ2eWpT?=
 =?utf-8?B?R21RakxMbVlBSnJkUEFXR2owNXY5VG1WVTZvQ3VCRllJaU8rdEVQaFQyMEFU?=
 =?utf-8?B?akRudXJLQkhkZTI5ajlkek9KbkVQajFXaTVoQ01nOEtWcmw5M2NKMStlY3JE?=
 =?utf-8?B?TUgvUTU4ZE50TnhiaTBibjZac2ZPZXl5Zzc4aTN6aG5MSkVDY0kxREdQT0dh?=
 =?utf-8?B?dUZYQU1JSC96MW50YjU2UFp4L205aDlpa3NQSGE5cmtFVW9xVjd6SUVjc25R?=
 =?utf-8?B?UnZ3ZWJLNWNjL1czanIwT0YvdGlJWnlncEl5WEJ6RkRFbDNwK1kxWnNrbmJG?=
 =?utf-8?B?ZlpPUDd6S1oxWUlzdmNtcnpYeGhxdzBPcGdXOTVZUHh0R1FIamJ5b1g5NVoz?=
 =?utf-8?B?aTg2R2J5NTJWVzdBdjRXV2VtU2dYR3B0NnluNitKVlVwQ2llZ1NPMFNVNFda?=
 =?utf-8?B?VHNuMXA5K05hUkJjTnFLbUt2OEUwdC80T2ZsVTRLQ2xJek5KbkVWYnBrR2gy?=
 =?utf-8?B?b0ZiVnQvSWFtOVg5ZmFJUmJsMGhxL0VUdklJdVhwMDMyL0VHc0RsRzdhbVQr?=
 =?utf-8?B?OExFRlZkT1VkaU8xeEVpNkorbkQyL1lHK3laMEw5NHlyS2VIdEJqYzhXb2Mx?=
 =?utf-8?B?TGFkc2p5RnJxcWFIa0I0M0V3b2VxckV0cXp0SmJRQThGeVlPcEFQdGZnTGxx?=
 =?utf-8?B?QVFMMWM4dEo4dzBWQWgvUUd1T3o3M1prZFVYRUtOcWtmS0hQVWFHRmJjSmNQ?=
 =?utf-8?B?Tm1LTUx6bVA4bVNQc2cyRDJYZEc5NHBRY3QvUWpHczJaZVY2dW01ajRnOE1t?=
 =?utf-8?B?bDhVMFV1cElPU2gxNHlITU1iODR4MVVTd3JrT3VyS3greG8yclExaVR6Q291?=
 =?utf-8?B?S3hKNDB6a3BqVGhleW02WEZvT3R0bTlSU1ozbDNNQUl6cFhaSEdyNGQvZWVV?=
 =?utf-8?B?bFlLMTM3aG9hTVNwL2tFZkF3YVRMZlkrQ0VPTlhNMHJpMURXd09lTUVqWUxQ?=
 =?utf-8?B?MTdpSGNoTmFrYmliWlBmbHBoMGw4QWI5NGNtNWZQM1Q3UlpJSWdaSHhwRHRw?=
 =?utf-8?B?U0VqckRraW1xVHpaZGZUcXZXbHlCekVFajIwN3h0eWpQOFNVcW5jcWRLamhG?=
 =?utf-8?B?ZHh2dk1IMGpXQS9TdC9iaWIyL2tYTkxQQnRjZ3BVRzg5dUNxU3FCL3cwbVg1?=
 =?utf-8?B?ZDJzeGkybFI4QVdMY3p4ejRVZXRPTkZGaW1qYW1xODlUaG8vZzRidkFtT2Qw?=
 =?utf-8?B?OEVTeEY1Tkg1bm1kaTFHS2k0S1ozbWJ2d080a0NYVWVRbUFhYmFHUy95N1Js?=
 =?utf-8?B?WjlpeGtjSm5CTTc3eDlBaEh2SmN0aE45cEdROGJOa3RsRGJWdksvQkZoQ3Ju?=
 =?utf-8?B?cFBtdnFkdnpodTZWQ0MzZEwvS1NaWnN6U3ZOaktvcElLYzVUeEVTS3VvQS9M?=
 =?utf-8?B?dURyeUlqTFphNzhpMGFQTVhvVWM1b0hneHM0b0NJVTVjMk5wL3UvMHZsSWU1?=
 =?utf-8?Q?7sSq4DGjVPPvRbhcC3UHy00=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daaa23c-211a-483e-25c8-08de13290d30
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:13:37.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiWTkv95lX/C8QSRi5nADx1uT8xjxPk3OEKP25xJnKu98x1QFgRfxaPxm+bMG8VCFGFd39jd5phQbzRBSfZLMHEQ/Qz4eYDrgmfoPplZSf2jM8FflP8Q/GRTtZ9RrQv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7521


>> If the use case appears which needs per-node scrub rate, then you design it this
>> way.
> 
> From the ACPI spec RAS2 scrub interface perspective,  needs per-node scrub rate and other
> scrub parameters. One of the use case for demand/background scrubbing in a specific node
> in which frequent corrected memory errors reported to the user space and CE count exceeds the
> threshold.
> 
> May be Daniel can provide more inputs for this question about use cases?

Hi, sorry for delay;

I do agree that per-node scrub rates are allowed by the spec, and it is noble to
surface this capability.
The way the driver is currently setup, if we ever allow the user to specify
scrub rate, then it would only require a change on our end.

However, at this time, we do not honor user-specified scrub rates. We only have
one rate; FAST.
And when the scrub rate is changed, we simply ignore it, for now.

Therefore, we do not have any use case that is sensitive to per-node scrub
rates, for now.

Cheers,
Daniel




