Return-Path: <linux-edac+bounces-1446-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36991E6E8
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 19:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E4728114C
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2416E89F;
	Mon,  1 Jul 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iDdpvudZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43772125C1;
	Mon,  1 Jul 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856310; cv=fail; b=bGs3/s1ozo4HPsoHRavzzWd4mlqfqPzo57uTIdyVxwn40anJTYPSYPslRFO3Dtm8MPhKnaCx72h1KeUtNEUul7/5dtSFSuk3HpFA/pWfnJ0i1/5K+2/Dkb3RbEccdoB/bjAjALjcKmTHdC+M4xBiachvRW+ErVxCZXDjIHTTxx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856310; c=relaxed/simple;
	bh=L8/2Ey9VunhzIYHucFzUJ66y3DbJq8uF4owgAzfIfYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OhdT+qp2jtuG7hi4aKcv8Qlfr1eR454vFhDohPDxHyHttMaSE4eHfUvttA8/PHwrm+j2jCKjMu3vBYA1XSvi70/oKbyESLOu3qlVJCs3Emp5wAj+QnOGGyMLstAP6t69OkvsprsYYtAQ7ZKf7fEWP/hsfOSqBHEPvW+XJy2rEjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iDdpvudZ; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDxbowE+TlZkAaEt3n/ymfGK+MluBB4ly0IsdqYV1o8Ps1EqEpqpMkWo+bBShJlGyhiuI+FIr1NYVNOr8Xxa63ad5KXyobhxgur05ZDtMJ9qAXTZTAjS2DWe8NIONGdcQUYB1SZtBkfngK6U2o5X4AswK6+eX/1zTjsgbZYL6+xmBdXs6tuh+NDKF7j9zjTCJ5MB5C25mrnVeX7h23w3vMsExXmfKEohRCTpaeWnQulzVcYSA42M89azrvWEurnc/PlBdnvuzBXn4jRVhA37yN1nhSJwC7UThDDNb6Ry1ZEY8f1KL2AIVwyaRZS0e+KMj5V6t9co//du6zh/ma+Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPSUnxJFnvbuofsRShsEZIojBx/GAX6SoJeMBuMn+EE=;
 b=efMFyWoctImE2JmvZoUF7fxTeBP2M0XvnHP4MgqAJxisnQEGljDrobUjX6KYEttA4R5sAoAz+IuUWB0JQNMVciSiwVL2NGUKDEuK/52Q8lQW0BOj1vGGGYCxUwKrsz6WK6KyRuz/b6O7FmWfMZ7HzQvUHMI1PH/JD789ve7S7vU44fJoHmdQHMBIjyVTzKT0ewCiXnr8lp1X1NNhySuJge6EmLUGHXOrQdaFNUcOoZ7e7JTFm49b0kzuu/URR3TaHnn9Cq3Vl7eWs1W6acAHo1i4YYOKztwbcyu4fN8JzBL2/X+IEkS5r4dv1LqPYv/uZEfEItydvQvpllUzmHD2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPSUnxJFnvbuofsRShsEZIojBx/GAX6SoJeMBuMn+EE=;
 b=iDdpvudZtnlFdAxsXGqrlmFhA4GdshzxGB1pRXFSyZIP/5W2YUU0y6uDd23h0gQLHjG2bn7jcqxVQpXwxudAB93Cs5aEhFOECautGE2JFw8bBTLrfq5VSEwPBIbfZk6iNdavbWM1VlM2ByabJrmk5RX8JU5FCKMPZZsFKKLudkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 17:51:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 17:51:46 +0000
Date: Mon, 1 Jul 2024 13:51:42 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240701175142.GA4681@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
 <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
 <20240628141542.GA124261@yaz-khff2.amd.com>
 <20240628144535.GAZn7Mj4jofP3Vz2xf@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628144535.GAZn7Mj4jofP3Vz2xf@fat_crate.local>
X-ClientProxiedBy: BN8PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:408:80::39) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f1b095-d4f5-4d13-434d-08dc99f679e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0OP0tSYbMUH9oQ8yWOgyFXYDICZsefv9Qx3cuL4JMsP/5ylb/CupEycF62qa?=
 =?us-ascii?Q?B0iXiQfGRIVsyHG6cvphr7o7znSMMCjNRjY4C7japKNFUL8kvm3+DeanmieB?=
 =?us-ascii?Q?1KGX2njEB35GcznOyxoD7URyWoe8O5A7guGBW2HUvslvzWfPWUpOa3E4EgOO?=
 =?us-ascii?Q?mMDu9fqZrynnWhmzdzQgWVE7s8uUbf1I1+4bvd1G6yb4qoExVEiHFuA46ND9?=
 =?us-ascii?Q?359Oeaz5S1PGEMuEQPEr2xJXi1Py62eN86yJJAukK/f8RZXJL5I8qiGEz2Up?=
 =?us-ascii?Q?a78cQO3+me20WHrMCZWWPtx1EMbmrA0RE1qboGrlaUJ6EuveapIjyDdRxo5K?=
 =?us-ascii?Q?jdVyN4t0cj1xtdcyzNCjry1VGwLGmMhlWDXere/4orwARUw3NrwmCA7hgqnm?=
 =?us-ascii?Q?5g8LP6CWSLSKrXcLKVSwkMLZHImr1VZ+xgDfsyeXYPCs+cY0P0i2eOu78XaU?=
 =?us-ascii?Q?EEvDow6wG3wC8u9smSwZS4gVo/Ne5GAW2XN9FvoUc81yO96z1BWLmncQSnG5?=
 =?us-ascii?Q?s4VLalPaFH8feEj3r1Ap0/NoYx25M7XkipznbKBOEh0O9WTZue44Z64jfcN5?=
 =?us-ascii?Q?Yw0WQRJ33zkLXPWE+CqMVLzGA5xHlpj4ZrUrfXWkFNtTtB1RRc878Li1ZnsQ?=
 =?us-ascii?Q?/ZKNQqJe25+hcHHeoWNKg9TDEYt5Fjvlm53FiWrhb2H/foQ1X+eOVrwI0cj1?=
 =?us-ascii?Q?J9Z2spKTSfExMNjmHgb9oOqpMI8jrEWpx7Vduz7mqrDd7Oy3DtoSi0Ocqbgg?=
 =?us-ascii?Q?NG9Rc1fH5k+NVT2I0Ge3MQszd/wm5/umXNz0adCpEQEMSGuugz2NbkpQBPN1?=
 =?us-ascii?Q?2+5AIoPs+Lk8gPi7HUT22G4heb0R3Ao6+Fq3+6tbWH6iSFm2j3iSxgRICHEK?=
 =?us-ascii?Q?L/BKheDCHITv1v+CmLENyPluZRHqmLZFyh+FmoGUVtUzuPUXi4mBAy48x/ti?=
 =?us-ascii?Q?dyKRAA2iwLpB4TGeF8CxGFVHmh35bgbtCiYxOB239SnJQPCSUmJtzZAC7Cal?=
 =?us-ascii?Q?Ius4Ej2wBvKL4v+4i9vBwqJ2RhZcjxIYLnN6pDJ0shBNqE25MLr3ZmHywTyE?=
 =?us-ascii?Q?dUd7E8WtYA7D7QBsOLqD/AvjnCniRXgSQGZvwtK5/ODVXtAvV0tXSiKHPsfO?=
 =?us-ascii?Q?Ra9GA8NSvlC1eVXMYnvwtcAOj1dO1DIXWuCcMB1tXfI+hByrbYxdy7PxH3h/?=
 =?us-ascii?Q?nK5hjNUHYd/RWFWLOPZlLqDsVxn6MRWn1QxU0nu2yXTQNb+NgyHQwzMUAHXr?=
 =?us-ascii?Q?s2mDM92+qpn0/yP54UZQ4z+tvS4bxOkdcxVowNSF8kbCzqhkc1/2E/tXS9+w?=
 =?us-ascii?Q?WxI1R9YQgZycm3nUDuiXD8NR8hzo1a4hK3u/ZJ+c/xFGkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Noxny2AssjTM/Qwvoe4OSYEwtEJ4gCutBm3rntrecWP8plTo8RKgyVgDSXs?=
 =?us-ascii?Q?mzHRbTn/NgbAep0VJEb9AVR7Tsc/lkVvTFl9qwdfgtCf8l9n/Mn8ppectdYi?=
 =?us-ascii?Q?X5onyFb5y82bMe2R6uWNCRFfXdscZbyruHEN9BeSKBz87HmyX5nK4ytWbpOT?=
 =?us-ascii?Q?jihrJ5/blM426aC+afYfmoAE8vv0U+AdXnvIxo6VStFUKQXaJhZBfy7srcjS?=
 =?us-ascii?Q?+EvuNZoTKun1VpTxmNMIGayxNsdBzCJd4wSz6svSFa53tlAZE0UG/3hDpvKu?=
 =?us-ascii?Q?BA1CqBPkoBtYsYvmOmmb2OUZAZqUl8dYwj67HUwPGIa38ruWo62srXcAN/lN?=
 =?us-ascii?Q?X1A1uS0PM1FQ2sVOHcrXZoAzFAPn9u5UZjnbrDWlYpsfUJGOnKnn2mQvuNsS?=
 =?us-ascii?Q?BubF4jXLU64tLy4X/cmUABEWEqVdAiTGTKurbC0GUgTKo7jtY1XO9q+IcDuT?=
 =?us-ascii?Q?ynr7DGeshT17OKV3BweDccuew6Jwk7jmvjEWUhYY0X1nE/xwPKZ4oVRxYGt6?=
 =?us-ascii?Q?icXHbcMNUGKD9o6jGWqctOMrpRG9zfBz/Sxmv2eXxC35dMWTRcaMeVOCOi7s?=
 =?us-ascii?Q?aFB/ERkdrCvoPdsVg87h03igRerV2fOrDBxL9YfkhUeAQ1sc4O8TWB7jT95w?=
 =?us-ascii?Q?OD7qohQnTx4t5au3WBxf4crx6+bbosMYiDKDXmrkydd83l6I55SQS1Qjt9J2?=
 =?us-ascii?Q?+t9YPZUz+msV4q2UplEL7rOMC728E+Ilh+cX06W+oApe5/AOu0uiQeTPb6NS?=
 =?us-ascii?Q?XIM+1DH7JR3rDe//91ADn9YXB3o4JAJD6GiWrqYG/c+ITEF7hJn1/A2WeR+E?=
 =?us-ascii?Q?t0ege4EzTkX0ryUSgILMX1a/T6f3g2rFBsVSw9WLc3wsbrrKK7nr9qjDAiCI?=
 =?us-ascii?Q?BpM9UyGOoSiFazx195uW1LrOP0erp35LrpNnVhpamFjyu6vYWUQOzItkp5Gm?=
 =?us-ascii?Q?znapM8Ux7Zez3EHN8iA1T6D0bHlFFQO+dnJM2zmh8AVblFJ2aYKq9UThDaaf?=
 =?us-ascii?Q?MivJB5xC8CQpwIHztNYnLXtyg0/eXRxUlfloKeTBMLfq/SHKNtEN+nS9DUkE?=
 =?us-ascii?Q?ZTSaM7h2CMMibRVR+fjQIxvR76pO+E6LU9j00KFNHc4/bwFEEmVX6qbOXGR+?=
 =?us-ascii?Q?LAphxditDP5GyXjVo3J91BJtscGsRgEJWv7abVaAZMyIx1t5Y9f6/zkUJJpG?=
 =?us-ascii?Q?J4vwGMdldME1uvVK9id6UVkUXSjNcoTIDERKpTk0oNx3EH+/ajSpSPjvmoDh?=
 =?us-ascii?Q?r08HzuIWsq+ehsa6OWA/8GBcSOlGF/1WvyVHCO2XDB/fGr67cn8nv55m+m5e?=
 =?us-ascii?Q?0H63gPezTLccTMIohf04Inx63safP0YtgeHjpLVMW4l3cdFNTA0J4wBjFMDb?=
 =?us-ascii?Q?ROpA4Rkj7j8gvmZ6vz2ad/WATY8Zr7pBu13+8A+N3CZqALszxkeaOeVfdG2n?=
 =?us-ascii?Q?H+XMmVqnTnMBvbZdL9WSnoGN7jxJXBzkqWBw7hBSZga06JSyH4QMgGdyWUFR?=
 =?us-ascii?Q?2J1pNv+IPFJxneud3hPktsnqj6Xq/vVMem3hF2gLwKlvdBbZO2ptzwTqnlKM?=
 =?us-ascii?Q?g7iO9X84VBnXkEKESLmgoM+mwV28SlVQK2plteJU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f1b095-d4f5-4d13-434d-08dc99f679e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:51:46.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMS2EVWVIAmd/s9MpOyidWOKdvYVHlkkoPJWtvsTSwPyL0TV9Lk3RCBXOApYVOKk16RGEWjNUGVdcVOStS9Wlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

On Fri, Jun 28, 2024 at 04:45:35PM +0200, Borislav Petkov wrote:
> On Fri, Jun 28, 2024 at 10:15:42AM -0400, Yazen Ghannam wrote:
> > Thanks for the tip. It looks to me that SMP and X86_LOCAL_APIC are
> > generally independent.
> 
> They are?
> 
> config X86_LOCAL_APIC
>         def_bool y
>         depends on X86_64 || SMP
> 	^^^^^^^		     ^^^
>

Right, SMP does not depend on X86_LOCAL_APIC. Otherwise, there would be
a circular dependency here.

X86_LOCAL_APIC depends on the logical OR of a bunch of options. So it
depends on "any one" of the options to be enabled. But it doesn't need
all of them.

config UP_LATE_INIT
        def_bool y
        depends on !SMP && X86_LOCAL_APIC
	           ^^^^^^^^^^^^

This shows that X86_LOCAL_APIC doesn't have a hard dependency on SMP.
Otherwise, this option would never work.

Thanks,
Yazen

