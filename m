Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1B27CEF7
	for <lists+linux-edac@lfdr.de>; Tue, 29 Sep 2020 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgI2NVp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Sep 2020 09:21:45 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:24416
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728362AbgI2NVp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 29 Sep 2020 09:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw7SebbMHfubDpAAmiP0scq/qV3++RZjyQ56sEDEkcV41OEBYzDUE6hgxjz5zlODV/IFA/GIpxxkJPlMbrwtwz/MCZOIf6P8Bqih376HPzjaR50mvgdcGojIgAKctQf+Tbw4/Xyfcm/i4egvP1gTFpkTuOZ42aa4DDu1IsBNgVKMfGTxVG0G3fze+MNeLxqvRGUBZuiLLeghuslaUFAOM6ZrcDEuGBMdB52voSh6Mkgsinfs7nG5RDeJXPNNXL41JB/WlqXf6VthQaUfv7QWcOxAnESrxhlDpnE6DfGjQpQ6S92wfzFVwEe0oCQcAsP1OMM8EANLgMGUUKDtrlrTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWucHuUMxIik2nQUera2p3jYPamAy3cSiaqNTXKS6g0=;
 b=hKqLTjWtj+Ibe3Tmc7SLMyKijtS2vOx8wo14OLy3aE1I4sNYDTpiNcuQwXRsisz1VjlBSxGuL1DEB0Htacki/vKGYzp+ylsa+3lZFrc22ZVoYhwZ6nVgwZoQyAEMCL6u1FC60FL5JyPGAkqCNeFg4DPQG7Sze1gNRFlAhiKKXtp79unGyUPCdmAj0nXSKYcRu8i4jLtp0KFsxnzpISRchfA5kW8SKXuZuprpEL/5pLHspJOwEv7prKwboAb8ab+sUATNXl8HyCzTtTtpJ6HA9v/YZuD+UA4MUVPlksts0EJz3PnkOYNgSk5dVeM6lOWwFMYJPth93RzXHQj7Gqq3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWucHuUMxIik2nQUera2p3jYPamAy3cSiaqNTXKS6g0=;
 b=S//45ty/RKRrz8uaDf4zHGMNlwvWTmtqLzSn3LJ+I77lWP9WKMcPr4kFKCMW6HMEbpR8uEcyETslI0TwAUVi5YbDibtn/4Gaf7o9mkHgWFcyE4FS43Iw2Cj0Vu+fuFBzHVLL2rznoDfxOI08qCruvzLAOQEg6MEkaUJ0YxNOEw0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (20.178.210.20) by
 BN6PR12MB1745.namprd12.prod.outlook.com (10.175.101.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Tue, 29 Sep 2020 13:21:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:21:41 +0000
Date:   Tue, 29 Sep 2020 08:21:17 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200929132117.GA2219666@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
 <20200923162510.GB1684790@yaz-nikka.amd.com>
 <20200925072231.GC16872@zn.tnic>
 <20200925195127.GA323455@yaz-nikka.amd.com>
 <20200928094759.GF1685@zn.tnic>
 <20200928155350.GA926956@yaz-nikka.amd.com>
 <20200928181407.GH1685@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928181407.GH1685@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:3:ef::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM5PR04CA0066.namprd04.prod.outlook.com (2603:10b6:3:ef::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 13:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbdb2ffb-0647-4c3a-282e-08d8647a9a6c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1745:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1745DDADBA5BCA2C663D932FF8320@BN6PR12MB1745.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJmkgIfcz0462gYcHNDmisfOb1D/qz6XR8t37PhKZTNkzGjsrjUQ4cTOkg05UpmbtdJn4BWbsKBbmbbrsuKfe+zRhBtrp47hKxrtMvTZUeZNO0yH2GwYvRCBRa0HFWtKvgMKQlu6IboPLyayYL+cSpi64JyH7H1kgFlvfhdwcrB6Enyzl+LzqoMyDYB46PSbif9y4eYUC4RRxV0C5DD0+GBqcfX2FOYdk7P4Uc3J1jhKvRqKv8Q0Kg28PYtMyDVPmMk5RDG1H3wnD7mtFeoZKV2LI9zvFbKJ0qiCmqBbD3aUZb9NOXVWV2yATWTL30CFFDWncnmwDuC9F3ZUEV/cCFUWCtRl9JHSjkE1T2SEOJ3p0f1+hxr+yFeJ5u5PkN3p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(478600001)(8676002)(1076003)(316002)(86362001)(83380400001)(66476007)(66556008)(66946007)(52116002)(6916009)(7696005)(6666004)(4326008)(5660300002)(44832011)(8936002)(2906002)(33656002)(26005)(186003)(55016002)(16526019)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gHPu9Oe2hDEk9/3VJOQj6JBAHSjvElzpzjF2dKNo7Ur9ba24P+808FAJp/TWwTcnUL0rIzI0foLrAgpDIpwupg/BdQsYSPzeV6anIQVkLcwk+yL46ytps59BIGD7A6m1B+gf/PGaa7sMI4oL0TnH8fIvdTHx2L0gyoO/6nRVeYN9mzq1i85Ky9BsuMDZ/QmiqQ5Nsv6mSZP/kCkYEdifeS5I1N7jY0ZYNY/TONTlOs5mGvnypSDc/mrehSaI3U+InKe0TtqaDRXUPL8YDQa3DBGpqUtW7uV3v6F7HI11O/ADbTEKDYaRhHHLvEMWH3xtPkLsi8HwmhP2JG5l+z17pbXjDQqbuVhKJKac1R9iDXS24Id9uxXYRjumET8fwbbWWV2t90/u0swa3MheX0tK5obBK1snTNazExCw52MPus+obwxIi63ZyqntuS2CHyBQS8iivzpqtN1iK1LLY6PELo156LGZgsB0Ji1KrBUJVwTGjZb+IBgIesAwMfQzym06i6YJRWIL6trb+WqBGDQsnPko5T2KQQ8//F5uKXrFIQ0LyqckIzFbCiDli8SYsVC81PkvMq56Iicduo2fz8E5DglAJPHJFhjkt+0qAMqppneFxwQXnJEaiCDmQliR30A8iq7HAKM7zemBXOny+T/0nA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdb2ffb-0647-4c3a-282e-08d8647a9a6c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 13:21:41.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCb8CWLKGahIZd7AH1cE3ntrE8/FEvYboA/KB7LYcwxXDglddnfeRspUVRFRzU49sfCm6AwSctXNGYcvnI7i5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1745
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 28, 2020 at 08:14:07PM +0200, Borislav Petkov wrote:
> On Mon, Sep 28, 2020 at 10:53:50AM -0500, Yazen Ghannam wrote:
> 
> > I agree that the translation code is implementation-specific and applies
> > only to DRAM ECC errors, so it make sense to have it in amd64_edac. The
> > only issue is getting the address translation to earlier notifiers. I
> > think we can add a new one in amd64_edac to run before others. Maybe this
> > can be a new priority class like MCE_PRIO_PREPROCESS, or something like
> > that for notifiers that fixup the MCE data.
> 
> Well, I'm not sure you need notifiers here - you wanna call
> mce_usable_address() and in it, it should do the address conversion
> calculation to give you a physical address which you can feed to
> memory_failure etc.
> 
> Now, mce_usable_address() is core code and we can make core code call
> into a module but that is yucky. So *that* is your reason for keeping it
> where it is.
>

Okay, we'll keep the code where it is. I'll work on another set to call
the address translation with mce_usable_address().

> Looking at its size:
> 
> $ readelf -s vmlinux | grep umc_normaddr_to
>   2864: ffffffff817d8ae5   168 FUNC    LOCAL  DEFAULT    1 umc_normaddr_to_[...]
>  91866: ffffffff81030e00  1127 FUNC    GLOBAL DEFAULT    1 umc_normaddr_to_[...]
> 
> that's something like ~1.3K and if you split it and do some
> experimenting, you might get it even slimmer. Not that ~1.3K is that
> huge for current standards but we should always aim at not bloating the
> fat guy our kernel already is.
>

Okay, I'll keep an eye on this and try to slim it down.

Thanks,
Yazen
