Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC492DB105
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 17:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgLOQM3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 11:12:29 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:55356
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbgLOQM0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Dec 2020 11:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9NzcuGSxCOqo0O1746JXz62wf+YyeTtoaQx64ODkr68LTtsoV3hex7hw8Y1pnm44vXf4oH4XadJATUrcpcSOkJnGFuSRV82qmLzCUF66cVO+QsBdEi5tO/dgIqjfLW5JRpXRLCwgJcL6hRN5TQoWXkeCiz/2H6UKx8oiEGP0+3eUMcace4ramwnlQSG2noRYk6AbM7CkvJIfZsVVPEi8A3NIGY6EhpIB6g3F0BdnzFbn4f4hnWL++7/brZPVM24oieOILEM2AKMJUPtBPa83WQPEQUqM484RyNyxIe6Qy7fMx//x+H/QO/wu9IuTismyjoL0R/lznFU3l0kEH3EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30kS/RNfXTpJcP3lp2YzN9M4t1jcgbpCzbZV46qBVmQ=;
 b=JpSCmuLA/S7M2IprfqXSD5IPONQvXa9AhfFew/1gMhWytG4C6Sf9Yof8oTLde6dTDRpw/bg9C5kSpR+IKSjI3St8R4dEXRoaaggl6vSmtqHCGkGQx/3JbO9U0JCd9qkk9ml2IZc4SXtVB4iojriQSZWpwMsqUrLBCAn6+Sv1tJVHTkDyDmlSn7GHDNsaMIW+ZqgEUFGIYBrma3bUW3axNAnUuvahUiGk2RFTPKIbwxrkst75BiBrQz5xjoe+Ty5OWBvzU138R3jCsZ75/6vds/ESDuMnPApcaF4mGIJDu3U9xskGusDaZOUG8D+USbx8UD9SbvBjltAr6zEUtrMjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30kS/RNfXTpJcP3lp2YzN9M4t1jcgbpCzbZV46qBVmQ=;
 b=xSurqDwOWVrBFmd/S5EStTYgmJiXx4+UDIC2m6T5NrilY1qLZOKrINfFbNP4OoSHyLCtoeeDugDI8TMpzJNxwE1aqav5zqv4W8P+LI0mkS2jNxqoLllrPl9eNPDRpVrgJp49Zh/WgYYunP+8ekjoNkHHWBi4pvFnijdwHYGPP4A=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1379.namprd12.prod.outlook.com (2603:10b6:404:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 16:11:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 16:11:23 +0000
Date:   Tue, 15 Dec 2020 10:11:20 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC/amd64: Merge error injection sysfs facilities
Message-ID: <20201215161120.GB2122783@yaz-nikka.amd.com>
References: <20201215110517.5215-1-bp@alien8.de>
 <20201215110517.5215-2-bp@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215110517.5215-2-bp@alien8.de>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH0PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:610:75::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by CH0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:610:75::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21 via Frontend Transport; Tue, 15 Dec 2020 16:11:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5012c0a9-0bc9-41a1-991c-08d8a1141132
X-MS-TrafficTypeDiagnostic: BN6PR12MB1379:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1379543A83AD341EEA1EF99EF8C60@BN6PR12MB1379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWcLoHCOJevUR3PaesfTiOcEYF3h5WMm3IqrvoJeQSLBQTgief0uioai7J/jl1ASivSIPxh07CFMfmgupSZDnvd5EV2huhxhaEnrrxnyenw4tx+9V7NUGfhvMSSjVii7rMPYkornfrhiI4uuLTUZQChRzen3KA6jAltPT3NNOWUsutEY9yHUZuG+vRUbqG22EBg5lSo2h7viZ28v/a0wxiR+BNAst0BgkInhi8aJbL5GBR+01pZhhjgWYqAaI3flGMBcX4xMiIggXZF8cLc/H07lPJP+/CZH88MyhefCvVKO0ciuYfc3AkvTLKanKnqA5kwOU+3SufQZOIN+Oj84ma55GkikpW4ZWATE1mBMHrVhAoM09daKvNI6yWRmFS7q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(66556008)(66946007)(16526019)(186003)(6916009)(66476007)(26005)(8936002)(86362001)(54906003)(4326008)(956004)(8676002)(44832011)(5660300002)(508600001)(2906002)(52116002)(33656002)(34490700003)(83380400001)(7696005)(1076003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6aseLHWEoEk6OQUDLxdiedm2t7RB9bh9tbyK47XBur0XOcw62S1pYySyaqGu?=
 =?us-ascii?Q?3jc0neKIGqxIdzuWpxysGHJ3Ir/z3rOg1R7xjZrToXe2bVmhD+qHjnpEWjej?=
 =?us-ascii?Q?gyL6wIcpaOPW+rRd0cemmQpWafe6H4zZ2hkilusQLeRHy82j1odJgea4Z/Zw?=
 =?us-ascii?Q?2U0XVoBoM+BvC6cl2GWIhekpDR6OMm0W0aNBjOTPFj7A2RFrcPNotIVceA7S?=
 =?us-ascii?Q?dxZGpnSU2UVMOL8j4bTcmOV3uoaI+xMhurYrbW4jjp3027+ry6gEMW6KXY9O?=
 =?us-ascii?Q?eyYZda33C4F/jtNyqVWTy7DboEVAodq8cw9MYaxKDlFiOdnXqjsmnJfv1z42?=
 =?us-ascii?Q?pWeKTupOzivy3d8UQ4l5QOPQcOVVX37vO4gyM74JCXXpsJz+YqCOTE6bgyAl?=
 =?us-ascii?Q?irhH8VxBAg0mjJhbK84wh4z8XYd0AjUruyVRrRZsx7AZLoD/he0jkwB8NJZ7?=
 =?us-ascii?Q?rdzKOMTlAsw56AlOBZa52t1FWGGUaRHAKd6HBX2IQNUuY9Wna7a2PGjjXvQJ?=
 =?us-ascii?Q?2+Ebp2YdH87xGCxgqwOcGwAjztOjyNCdh0IlffsOrCYPeq8csXH4UIUZUPHa?=
 =?us-ascii?Q?gZBK+8wyn11UMr/oxwo8xAr/Xa62ljTsnUq51J/sx6mpbvT3NdiXwcL7KyyL?=
 =?us-ascii?Q?VvTs99UZJuAlVzlpLI/Uvo3S9veRoRPrndBuxQHx021SbmYShhoaLnu9y3JW?=
 =?us-ascii?Q?N7LChih/lk44Z2FvPSFIVBt6+yUogNKuWigXfMPOoFSV+ZoaphF2wrvA0s9P?=
 =?us-ascii?Q?kkY2ejU3us67oS/ENSlBNgpw8azJN7SEgJnBTML18iSteE0iqORec0TxU6P7?=
 =?us-ascii?Q?VJoVrf/+JGKeFd29IEGWjXAkiTuR0w8MykqbK4FAqg1TYVv/xOUXgsUT/ERK?=
 =?us-ascii?Q?4lhQwW8o2+SAHMVzso0t6QgNh0S50Ul24tDwTEPotZVWRQz3JuZAeQO7Dm+a?=
 =?us-ascii?Q?Bt44lN45rFhB4dIMlHEUzmGCmS7ZTdXNvDbIG6cBdiMVFSRol/yVlaSUlwvP?=
 =?us-ascii?Q?ycun?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 16:11:23.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5012c0a9-0bc9-41a1-991c-08d8a1141132
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BvODaHiII+gsh414QnnIsx8WgkTAMx6FJyEW9BMnxHvSFg373k9hRuq58LcM4WhW+twtXDPJrWJYSE03cd/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1379
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 15, 2020 at 12:05:17PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Merge them into the main driver and put them inside an EDAC_DEBUG
> ifdeffery to simplify the driver and have all debugging/injection stuff
> behind a debug build-time switch.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  drivers/edac/Kconfig          |   7 +-
>  drivers/edac/Makefile         |   6 +-
>  drivers/edac/amd64_edac.c     | 237 +++++++++++++++++++++++++++++++++-
>  drivers/edac/amd64_edac.h     |   8 --
>  drivers/edac/amd64_edac_inj.c | 235 ---------------------------------
>  5 files changed, 236 insertions(+), 257 deletions(-)
>  delete mode 100644 drivers/edac/amd64_edac_inj.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7a47680d6f07..9c2e719cb86a 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -81,10 +81,9 @@ config EDAC_AMD64
>  	  Support for error detection and correction of DRAM ECC errors on
>  	  the AMD64 families (>= K8) of memory controllers.
>  
> -config EDAC_AMD64_ERROR_INJECTION
> -	bool "Sysfs HW Error injection facilities"
> -	depends on EDAC_AMD64
> -	help
> +	  When EDAC_DEBUG is enabled, hardware error injection facilities
> +	  through sysfs are available:
> +
>  	  Recent Opterons (Family 10h and later) provide for Memory Error

Can we say "Opterons (Family 10h to Family 15h)"? It may also apply to
Family 16h, but I don't know if they were branded as Opterons.

The injection code in this module doesn't apply to Family 17h and later.

Also, Family 17h and later doesn't allow the OS direct access to the error
injection registers. They're locked down by security policy, etc.

>  	  Injection into the ECC detection circuits. The amd64_edac module
>  	  allows the operator/user to inject Uncorrectable and Correctable

...

> +
> +static umode_t inj_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
> +	struct amd64_pvt *pvt = mci->pvt_info;
> +
> +	if (pvt->fam < 0x10)

Related to the comment above, can this be changed to the following?

	if (pvt->fam < 0x10 || pvt->fam >= 0x17)

> +		return 0;
> +	return attr->mode;
> +}
> +

Everything else looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
