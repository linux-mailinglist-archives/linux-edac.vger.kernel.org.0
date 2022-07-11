Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B079B570942
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jul 2022 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiGKRmE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jul 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKRmB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Jul 2022 13:42:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B46E8B0;
        Mon, 11 Jul 2022 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfa7OmN+cG3pH8QeudRXUBnL/G/1QROk32VHp2gOKoCn37uGl/LL+Yo1mBaGne/Ea1zWo3OHFRNp8NFhR52jx/idvQ9XvrsiD90HT2C1Xj++4ivantNa9aEGzi1FVKtJ34kO/vnE/x5/TqBzspM+VPsg8yWmdLSY/KmS11ccDaHp9anuZ6fm6HGom4dpnvqMBN1zwkG4ryZg/o2HDSsNoEo8kdFDnUFCXjrIKSYJoZSb6lp63NvRALLB81Acge4COn9VUXfuOnHgvF+sWVmNM2cXEC8KkTsEqIBtFmuIPpXSImQva9i6O5MhlJuWT8whXCUoz8NQ314C1y2yuglEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0QMAZ9j9tOggpdlUtj/iEHVvjwm4wQ7WsPJpP7zBP4=;
 b=TvflLqHkYTY1rBseosMHCCF+IeQIlimP0gNO4o0KU72NNBHf52qViKPXCGPH+KolOYr0blvl2G9HaOnjBvBcTgEeLslNH/C9mMoDl8GpNB4DIOIKlvAEg+NVjZWF1EwMq0SAyqzGZKrYw468ua74nt6F1KoB6w/KAf//Y0cWFUg0tDcWk8/HirKG6i+Q6gYWiHNoRe+3OtP2bxegsL+7qM7U2ecv2eq6ufNLsjihfyvUYOr/7LMAG6o3IICznlWVWnHlGJgdJyv2G620mwL2LCfcndn2dfiEclqHgzLc1sQq3GgqkpprbDM7cG2ZB76Vve37JsSSqrbqXLKULkAvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0QMAZ9j9tOggpdlUtj/iEHVvjwm4wQ7WsPJpP7zBP4=;
 b=yXCMhPkNNkSBo3yiv02QHhMXMMEnBMg9AAZuCbn8cAcmmXVjTV9FmxGd7FipaylSxi96jAAbQPk4vQW055i+V7GLH2k0FB/TbE3jOONsQ3aHGrz+wsl1ls+N6k7cPGGjKTbBIhkXFtt09Y2Dmsm5vfvcKbzlg5VGlbY5sIu8f2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 17:41:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 17:41:57 +0000
Date:   Mon, 11 Jul 2022 17:41:54 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 3/3] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <Ysxg4r1IAA2PasTC@yaz-fattaah>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-4-yazen.ghannam@amd.com>
 <YsKvVI/t2svrib1L@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsKvVI/t2svrib1L@zn.tnic>
X-ClientProxiedBy: BL1PR13CA0408.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e82dd1-e4ad-402e-fe9c-08da6364a6c9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POue+wDG5rQtgUBpfsxktuh6d7mgVY5jd7koorv8AwKYrJVvmGLBBgr0MzpcUV6mYPtzzHgCePkT9hTHz/lTbL1punRnaSav2Jpl9v3GMoqYYAVXBt3jYnb+lGKxnyzrjNv+PHTwXUoxLEPh5b0yD2HFHpEEDeJ0mJClWYaXEL1cIYtVy60lpDESeGi47+aSNe48HEqXbIvq8wlFQ0uBfbnUQ4cThfb2MC2jWUj1A8H6FxK4pGEkJTY2pwFzLh9VKbJ+6YdokKa7WKskex5Evm5r6NLG2EF+f2Iey9VMRgvzh/V0nYHj213bvmC+7RIbYHPnGPiG33lLGaGMZdpJ4V2aAX8+8dRjZMVcjRFAV4esXw5mdAIvA51Ty6ft3r+ATCrbSd/lhoG13oLfiaI5nRl3y/X8oTo00NhdndrMsOQ4MVGXfD8KyKS5BiJA2rfm1ftA+/Zd99bJLMkG+IODpAjpUlGDEucqjcWPSbVpsU4HhyHSv/buMYFV2AWVyDAvBMMA14aUP9lwM+BsmqtkA4iCrxDE/UvdP2h6x1jMTVfr9p58R0Dwx7wbk0ahywHwMEipk56Dt52eI5vyRB4c57LuE1T1nPffMYuSitdpCAod/QvZ44kI1/e4UBJSNASDs0+Y8NEoqhcVjONwpR6xmJeoqM0P/8qFYFFcBy4Ul9y4LV6M6uFIVSXvWQ+VHEYFFXdGiWcARh9CPz9tev2r1qYO1uiHczL5laOphcqqe/uFFH1Dj+RUNB+EQU3kpBI3LHjZ2Yo0OYX5tX9Uzri7Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(366004)(136003)(376002)(396003)(6506007)(86362001)(6666004)(6512007)(41300700001)(8936002)(26005)(478600001)(6486002)(2906002)(83380400001)(5660300002)(316002)(186003)(33716001)(38100700002)(66946007)(9686003)(8676002)(66476007)(66556008)(6916009)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqpKWIta+iIirGNwEnBbZWq55h99GMNm9NDtWlzut7u/CKP5mGLG1OD94joG?=
 =?us-ascii?Q?QRVO3yxh1XTuXqWIuypyApt+KbggtmiibNkPt/QE4w2Osp/HPrBhIBbANube?=
 =?us-ascii?Q?4qwlXM3UbjxyK7sfmptDhevB6No1YLvCwR7VsZqbPm3SLz4iZmBeWKh0/9BH?=
 =?us-ascii?Q?G6RXxIVW9aPQxbXVEl6zcDNhmRLyGjaW7nAvolZDLyiHqPY+XKEfVu53lBp8?=
 =?us-ascii?Q?Oh61Kz/LBfA6NYGnzqx4/rXBMdUF0rjCGxxyRU6HPIBnMFSgnysuW8nr7fK6?=
 =?us-ascii?Q?LCYh4+aEQOBxEuYrIxgctPG68wNIWSe1rY3LVidjqQKIWlU7BH47HmaWhFCt?=
 =?us-ascii?Q?Xv7LNXOoKPOf8iHciQlHwSm3e4UjVQwtAD7V/T1bM4blIJZQ85jGBy/jWXsr?=
 =?us-ascii?Q?eHbDz6b4fTpjMtmPUC2O+XgzFoyWsfhDraZ6TJjzejurjnrJVh6E9i+6ZcHg?=
 =?us-ascii?Q?dnibNHoKVOdffFKGnaKgEXR39RDXMFVAv+uBtZIUHCvcoLg4xeat4qzAG8RQ?=
 =?us-ascii?Q?k5Yo2R11C6yTIVOx4JKIoc4l/9koycWNTnF5sqpC4OFW/V4guzOh1X2YpPIO?=
 =?us-ascii?Q?6c9QXigbGt65w4rT4RBbmynRNgxrpYsxGcSRFFjamB+uAiAzTVOhCi0XzovF?=
 =?us-ascii?Q?Qq3EUK7Zu2WIxnnyDy49pk0q3LrhiQkhDsBJ/M1qlNwHkmwbGBoWfok9qsuO?=
 =?us-ascii?Q?u3vrzn+Ve06cqYxFs55UUn1MWhcmRQQPv/GmNjB0qlmqNuHj33DLvI1fhMIF?=
 =?us-ascii?Q?oFzDUPk59UXb9ElkYcwYVUSUdaZmbnLYqgTfQK/5583NO7bq+sfO8NrdYKP7?=
 =?us-ascii?Q?NNFn9qRIkXSkRKD9pfzA7mgzmYHpaDpH4iX8xQuwm1Bx1kcqa3nbdGIilMBz?=
 =?us-ascii?Q?yyrRXp2orhR6F62zIe5odrvjG+hBMTMy5ecgsZ87uku+z1mqSUg93sbxUG/T?=
 =?us-ascii?Q?UQ1Xh+a7PVlLFkZlHMqizblBg1mJ4SB6Q7qyYDAITUpmprxPx9jmEVpCUC+q?=
 =?us-ascii?Q?lk/B5QFpjWEVk2dAX0hxun4CHKnL8Is1c7jH1ulKZ/G1BSj8WGVQXODpRGH1?=
 =?us-ascii?Q?d1IBLUof72/hupYoiKsdlMDlOJK/OKPfGtQOJcxnKDAp/MbjFqsDEyTsY0eb?=
 =?us-ascii?Q?HJV+Znknu52LguJDbtc7vGln0+n2X5ZtjQhaY2DcFzUNhj/AYmu3eky+3Qw+?=
 =?us-ascii?Q?UFRFcSsnfi6WmSiDG2DUIN4Kqa+PetyRdJbvuV38wKieFMbmJZoS30ErfktO?=
 =?us-ascii?Q?AxpFheU1qY3BLLLDmY/PrOWrSpkHPrG7uf5uRiR7RTKIx5khylQkDDNBk4J/?=
 =?us-ascii?Q?LU9b/QSZ3STI4UbGQO7Z+ujIKKfyvfPa1k5SjN6MbqwpxgOKjH09WMzkaa/D?=
 =?us-ascii?Q?ERy1FKuVzXFOJexOJqyh9dn/jI0rnrqmzzESBoKmO4QR9MiRYzQGrnoxjVSG?=
 =?us-ascii?Q?0SqOoFixdkriyPo6EogtksoX0EPMdWRkgSEGveXP6MbOdngY1moeJFPULKo4?=
 =?us-ascii?Q?hL8R8CRkdwlZvcpKFhN57wUkwN0q3nA2zlWxklOIj+RpGahe6n3RtoqcnBQc?=
 =?us-ascii?Q?aqwbrg16Ky9K1DcdVlfKtPgRpEODSS0kbwQTf1J9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e82dd1-e4ad-402e-fe9c-08da6364a6c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:41:57.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOlt4YKbOLOsBAuKMgPJa22uoYDIpeZQim0Gt9gV+5G5XvOfoJc1yv87O7/mzAShivHTQw6PGCmMOUHrrBbO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 04, 2022 at 11:13:56AM +0200, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 05:44:40PM +0000, Yazen Ghannam wrote:
> > @@ -1254,11 +1255,10 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
> >  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
> >  
> >  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
> > -		u32 low, high;
> >  		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
> >  
> > -		if (!rdmsr_safe(addr, &low, &high) &&
> > -		    (low & MCI_CONFIG_MCAX))
> > +		if (!rdmsrl_safe_on_cpu(m->extcpu, addr, &mca_config) &&
> 
> This change needs to be mentioned in the commit message.
>

Okay.

> > +		    (mca_config & MCI_CONFIG_MCAX))
> >  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
> >  
> >  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
> > @@ -1300,6 +1300,17 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
> >  		pr_cont("\n");
> 
> So here above the code prints SYND1 and SYND2.
> 
> If they contain FRU strings, then this printing should be an if-else by
> checking bit 9.
> 
> 	if (BIT(9))
> 		print fru text
> 	else
> 		print naked syndromes
> 
>

Okay, will change.

> >  		decode_smca_error(m);
> > +
> > +		if (mca_config & BIT(9)) {
> > +			char frutext[32];
> 
> Why 32?
>

I picked the next power of 2 after 16 in order to have some space for
terminating NULL in the string. I can't think of a good reason it needs to be
a power of 2, so I can change this to 17.

> > +			memset(frutext, 0, sizeof(frutext));
> > +			memcpy(&frutext[0], &m->synd1, 8);
> > +			memcpy(&frutext[8], &m->synd2, 8);
> > +
> > +			pr_emerg(HW_ERR "FRU Text: %s\n", frutext);
> > +		}
> > +
> >  		goto err_code;
> >  	}
>

Thanks,
Yazen
