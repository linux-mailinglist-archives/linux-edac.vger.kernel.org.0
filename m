Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217311F6D8B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jun 2020 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFKSg7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jun 2020 14:36:59 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:6263
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgFKSg6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Jun 2020 14:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aujn15rrBLpe/fEiyU7Qij+0GsJiDOXYabpDjEZPjgeZNBew/Z5j5wDvTh6MqsrS70rR6mcJg61JrM59LtwtwzkW8hXbFsJ367Z9oaT4kp/LUbEQzmrHZ7RfPaHS1ssUM1CihM4HUHDP/JZ9fHgoYiH+nekm47aPGdHMSCXGnbiTFyM3Xi4BZNQWN8x0XMLaYl1HyZXiQDK66CEjuntVrEunT/i0UG/53XnVQuBE20fwSUUiTJin1YyJLNuEtl70cO9sulCBtdq/PUtXbV2Ba73Me2zTLpD44AMKXMj/HMlmlPqoYdGWxEC7cYZKpV/GtA+xiEjYyvCz92doy3jG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JSDRSh+ieV9wW3nZ0cXz4vhrGDq+MA/1K5AMbTo98A=;
 b=YE6NZPnq3Jtu+vaFVIG3hfOBpJWXBaaDOu7ORXxcNAc3rYZOikzBSL93ydMhGb0Nfe2z/2gBNL9EyR17uyU+Ts1h6yMUlgdy8U8xbAA2a0zbs4emVm+r+GXnMG90U3OnlOS5Mxy/OvU+pGUKrjS/4lgQfn0A4D66q9R8G5ZTai8cyqAO/aEKQnMBSpBUVIthOr3UCiQ16DQ2gcDG30HnRDA/kqyzTKg2N1AlBKKJq4zqXb1CweuCBHhATmJkyRVEM8AM/uDyClX/ny7wgTcuE+exjyyBAAuPjTJ09r0PmQf17qnNQbyCKG/9RIWZUW84lfkO1M/QeKrtfoJlAotTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JSDRSh+ieV9wW3nZ0cXz4vhrGDq+MA/1K5AMbTo98A=;
 b=y2+il+aTNMjY88kAkxpVMCs48PwV7rV9CiRPW5/gHDJnIBjqbeXCYfKRqn9cvIvNI1bqjyFlywWNQKSsYH7lMNQtp7hvAReW6Uvffd9kHFRb1logh3tCaKIuT84m//gy6lDWkReNQKBGKqfADRTdhVamWOMOd0pLyFl7sTxdCC4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 18:36:55 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::2c67:480d:4505:5314%3]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 18:36:55 +0000
Date:   Thu, 11 Jun 2020 13:36:47 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mce: fix a wrong assignment of i_mce.status
Message-ID: <20200611183647.GA255402@yaz-nikka.amd.com>
References: <20200611023238.3830-1-zhenzhong.duan@gmail.com>
 <20200611165500.GA3503@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611165500.GA3503@agluck-desk2.amr.corp.intel.com>
X-ClientProxiedBy: DM6PR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:5:54::41) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20 via Frontend Transport; Thu, 11 Jun 2020 18:36:53 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ac5bc48-1f84-47a1-80db-08d80e366a4c
X-MS-TrafficTypeDiagnostic: BN8PR12MB2882:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2882A225863B3D0F467A23ABF8800@BN8PR12MB2882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVZslhVwg+DBhOcSPY1G6OqsFQlo37+eeeb1hhsJaT0cqwfFbjumqEKOoDIZZtPjFMwBNl86nYq9X5pJmHaoFulU23x5EbQmGo5SAdgNpWRLi9/dnrgkVoOOdoOe60VpTAl5UTDAOs2MU8AI6BRWHVaBtDsXgrxSDUI9qiKrnmESm0f59boKwS5lBFvHVsqCzoX3sCpi85dYvd2PWlmG5ua0NADiaYTco65TaJj4mSsVAa5y4EcC1SPIxzDndujlP6lA1rFBtbLufrEwqB7vyP74E8Qw1AkVN3pSX58KIbH9k07DW1XfsJLdkqQ1GEnVFY2PVVfJHPIVeTfKmO/VTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(316002)(55016002)(44832011)(478600001)(16526019)(8676002)(186003)(8936002)(7696005)(52116002)(54906003)(83380400001)(956004)(4326008)(26005)(6916009)(66556008)(66476007)(33656002)(6666004)(5660300002)(66946007)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B137UyRDkMydVNUAS71QX1x1OgOYvesWJsXhcSpwVUFEtQJ9oEon5dnaAgluCEieRHvRxdLm/BLL6DAamnOK0OU+x07GpabtT3WBZBoiHi/1a+R+pPYHzcwlHrtnkjMv11bB5A1gu21f7NHYiIX7xEXP2Fm9umRd4G4007wAutPVmTrSta5zZL6jdYFKzjEEC2kvlKQ9Mr3gd/tLHKA3IJPzZJoAnnaLmGybhaJ53U4CK2hyWFkptZ4KoBivrS5jQigncloTejKbtftuU29biW+xdQCsNFkhrzSIpnm/iWBxJPXt9vXpTpv/eQvMpSFl4EN9kbztIpVkg/rgVag+07qZD5pOkFaJllFSasoi/yRAp0vLYQwWTEky7JqnpBGRsA11tqF4pUEUUsaMqMb30QcH8TcpH+wrF5Eg0nk4d69kBNw8KHOIak2+mzUU6mRoUIsP581FY0qHtpaWMOEXRSO7NP3B+S1jNKdS1PYcom0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac5bc48-1f84-47a1-80db-08d80e366a4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 18:36:54.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yiGzpjaY5mNhRYrrEc1GlinSXcaidugoqlbcZNnJk8KPqzD5Ni4akLs0uSvX3+4Y82nmABzoeQWzXp7OgV3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 11, 2020 at 12:55:00PM -0400, Luck, Tony wrote:
> +Yazen
> 
> On Thu, Jun 11, 2020 at 10:32:38AM +0800, Zhenzhong Duan wrote:
> > The original code is a nop as i_mce.status is or'ed with part of itself,
> > fix it.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/mce/inject.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> > index 3413b41..dc28a61 100644
> > --- a/arch/x86/kernel/cpu/mce/inject.c
> > +++ b/arch/x86/kernel/cpu/mce/inject.c
> > @@ -511,7 +511,7 @@ static void do_inject(void)
> >  	 */
> >  	if (inj_type == DFR_INT_INJ) {
> >  		i_mce.status |= MCI_STATUS_DEFERRED;
> > -		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
> > +		i_mce.status &= ~MCI_STATUS_UC;
> 
> Boris: "git blame" says you wrote this code. Patch looks right (in
> that it makes the code do what the comment just above says it is trying
> to do):
> 
>          * - MCx_STATUS[UC] cleared: deferred errors are _not_ UC
> 
> But this is AMD specific, so I'll defer judgement
>

Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
