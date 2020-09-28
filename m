Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0597A27B13B
	for <lists+linux-edac@lfdr.de>; Mon, 28 Sep 2020 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1PyR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Sep 2020 11:54:17 -0400
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:50443
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbgI1PyR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 28 Sep 2020 11:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKYt3UdFxqTsCzoFG6iC//RZpMQu4dmDxFyWabdaIB/Bw5PsndZzIGf2/QhTzzj+U6heEjOxXN4xdOAOunfDIkmEX70+JqWNTx5xkd94iTttnhcE3wvewx5m+bTyxw54j1APGvo87KIfJhPJIPRt4nTcKTvDfHefWpysW23IWscmwv+8H6M09BBe3+ZNxhLwm3gF0SNufpEXSmfNJXwNUyYmSylmpzNVqoNLD4cFxsbD1A1MtP8n4DEi+r5aqv1Bmbv6XTM3SnnD1dkdFddVjkusgbS/mH8LOV50Wz2c9JeLdrTBmbgJTd0LkoOLHOMqEn7tEo31W+zPt1xhZ+ke6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O0yB1Wjtm5vZAIc02PPv3eg5wsP+FL2uPcFl6kQnZ4=;
 b=aDy+3jDGuZ/pcIgv95GHYvhmVkW9/T13bOKg7790VFMgMInEwOzjZOQc805pcClNZwDoNf6dhn3e8mOvrNh+6nTenBapmeGyEtNX0lQA20PAoJgOxzeBTB+WFF2q1Pd4B3187HrNWd2N8jYf3zIGnbKtn4v/liD5FyrW5/28R7b5i797Qe8Z/xeAgMhVsRkpeh7WLYS1KL1it2EkpwHj1w8LF0Z311i4JHVG5TMr7O2912Ye60TelZtY0DTk2XXt/+I7ZWIwL3FS7A9GaEqj5bvJ/Ypsdg2m40QSuNurhGop0zY+SW4Ac4soX7C727G9Cf1UV3eNYD7h/GleKmCpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8O0yB1Wjtm5vZAIc02PPv3eg5wsP+FL2uPcFl6kQnZ4=;
 b=u2EXirIVDgG/xiE5XRUUD8OyBdqsHtyrHLl1ejEKPhKK+FcZLNFqc0Gn3CHX/uO3O097AD/PnT/mlf4iEJYnaQIqOOKGICmxp/uLsRxa5Ulgg7+ujOOUTB80ZvYQFnKPJSdM+ZSp1TjPIxYXnsqAENDb4h8v0XSY9+ta288aE90=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 15:54:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 15:54:14 +0000
Date:   Mon, 28 Sep 2020 10:53:50 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200928155350.GA926956@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
 <20200923162510.GB1684790@yaz-nikka.amd.com>
 <20200925072231.GC16872@zn.tnic>
 <20200925195127.GA323455@yaz-nikka.amd.com>
 <20200928094759.GF1685@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928094759.GF1685@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:3:c0::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:3:c0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 15:54:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5379ce43-d933-4c19-086d-08d863c6bfc9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02123767D79C26A25A9F8F45F8350@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eK6zBiJaj+7JIEoWmWpxgr4K4pswx5jN6/Mm3Dt1bfoH2kDNJrB53XjitYhIXOKpahnYFKNl7CV7OtP8TY17VOYH7FUz8FudpXaqWl1YVb+IjhBEPZhmvSTYgfp5yt5t1jvf9s3NAPEXekLU5YfxtCy29w4oN9I5JkEE67PJwnoIAIFEDVz1atEdQEDpBS71AXysSM3Lo5Nq0bn9bjFCYdG1YgYkFI77l89x9qz4UgY6wjV5KC9UFRqVEK4SnRZ/e699mvhIk1nPx4lCSwDIClRgeEpEPZZZs5EPpCnIE/DO7rXVB9YXixzITM2IBKusABu6j7TyOxZ5tHCtigUJybNaTsBlDYt2w59MaZm12x/NLWg+qIXMOw2GkRDYo+Ao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(66946007)(8936002)(956004)(55016002)(2906002)(478600001)(44832011)(6666004)(26005)(4326008)(7696005)(52116002)(8676002)(316002)(16526019)(6916009)(186003)(83380400001)(66476007)(66556008)(33656002)(86362001)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: C/D8P9PEltgUsF9/wSrHJZ3XUFrX35nM65hZAcih5v3yjQUEkRha4Fz5cshYZOiX6Ptbt4244+QnBeCYz+LWl4w9wleuWLYxlSTHeb5aE2ROCWgpgQ4xFjwjqkxGpqCtRnYArYLkvHLaj7ouCAEmzmGnCsnyvMedg3bc4zEpsBnhZMGjRa5CFx1DB3ifazFYs3C2e0i+TISAspPAIbeiTLcRnLq6lZLkHuIwmrFcwiZtyjoIH25epBVU55ldEDHBzhV6Gu7oqANn5OdI8FFad5ApYa/f9yFBHifnxr6ifM/25vVlDI2gsUebY44cR3OEGH0Y+uV56lQ3vnH1I4ZGez53/4vEUoGzF3ppi8eVNLBpaEJysTZWb4bZ2WsIrbVAIZjZTMp1NzaMZXLLr9Pa09HRhrKJ6xjMmP6DW8YhLOrIZGfkH004nVQ133tsCPEJSgNaPo0WuKJTu4LzLX8/H8qdcF19Xy2r5PjVUNCBQYhEL76N4IDwwj6xqfKO/HLjuACcb5LyijEjJKhQohJn9IpLNsObHqJJ4YoGl+QSUhQhCeOh5rZbQGyhjKJG1Asjnol9PO6SMrwwIMXZqrb+KGizCacezaGpMVPWumqdyaQb6/XkCpHYEsHlJXOsiGPoMyeVMc3iiGzfd9+NXsbpvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5379ce43-d933-4c19-086d-08d863c6bfc9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 15:54:14.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGIK6qqj2EBP7eaBEu+HX/NZ2aw12pqsXOnr66m0UjSu/ygEn8uvJGdWA8CSp0Li0HRXh+xjCcZDm+I1u1ykyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 28, 2020 at 11:47:59AM +0200, Borislav Petkov wrote:
> On Fri, Sep 25, 2020 at 02:51:27PM -0500, Yazen Ghannam wrote:
> 
> > The address translation needs to be done before the notfiers that need
> > it, and EDAC comes after all of them. There's also the case where the
> > EDAC interface isn't wanted, so amd64_edac will be unloaded.
> 
> I'd be interested as to why. Because decoding addresses is amd64_edac
> *core* functionality. We can stick it in drivers/edac/mce_amd.c but I'd
> like to hear what those valid reasons are, not to use the driver which
> is supposed to do that anyway.
>

I don't have any clear reasons. I just get vague use cases sometimes
about not using EDAC and relying on other things. But it shouldn't hurt
to have the module load anyway. The EDAC messages can be suppressed, and
the sysfs interface can be ignored. So, after a bit more thought, this
doesn't seem like a good reason.

I agree that the translation code is implementation-specific and applies
only to DRAM ECC errors, so it make sense to have it in amd64_edac. The
only issue is getting the address translation to earlier notifiers. I
think we can add a new one in amd64_edac to run before others. Maybe this
can be a new priority class like MCE_PRIO_PREPROCESS, or something like
that for notifiers that fixup the MCE data.

I can start by moving the address translation to amd64_edac and doing
the code cleanup.

Thanks,
Yazen
