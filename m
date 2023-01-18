Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F66726F9
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jan 2023 19:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjARSba (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Jan 2023 13:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARSb3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Jan 2023 13:31:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E8A9;
        Wed, 18 Jan 2023 10:31:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3PZZae8SoxdYYdnKORUtcIs3tVPlpJ8hmTDOnobmzH6t56LSL4639pVHKkDj0araK1jJZlAIZkXMHiHT8SKZ3RKEQToTWBgyY2S+BK9L7N8bhxN3mdoBPEuCzLbBGbOGcx7avaaTRlGDA8I2beHH2mbKMTvFKWP2VLJHJZe4OMzh1VaWzAbcMfo+JpnBd0w8J1IknskVrXgm2yKnCEA7cwrjbK2uM6Qq7HdS8pfVHsFHAr9lquNgx1yMxCRa2e7uzWoi1NMnDakUBwlFuF4WbGCedJOUimTD5yHXGBhZ7SQpL1mIqaqJ53RJUZ2U2dbE8vMnffLdvL6VyzOJVt2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f64Nj1ui5cocnhNGz+vtcFzGWPgF8KuV2smkFowUEbw=;
 b=alheisd57mw8PJ3UxXpduEylqH5XgmmzvCD5Rd2Mp8FR7t4DMPB2yPMd+1tuOE5KfhmfVTRcyCJbQZBQwGZ8p50iFWt/Lt35JgOeTb8e4z/AOdHBQXmVeTQvXc2CohbHaXf0m9Yv1cU7RRoisBRufRicB4aDgMDlbAEnvw4GXVynbe3l3Iy5D+FMsAWu6Piz3ZwhzPX0ddPS70t0cdKy8zDKUp+sjoFWRTP0jK1BGT4mb44+W6Ziq92pWjCBc3hneefZBQpujyEhf5Ucs5oPtp02gLAoxHO2aAHCETc14PXtvLcN0Y0hEKHPju5XRab+b606ZrbJhmdOP4TvSyGsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f64Nj1ui5cocnhNGz+vtcFzGWPgF8KuV2smkFowUEbw=;
 b=e+lXrny3+V21EBwocb+ef92wE4sGZyW3duWSKyng5FLPAy6sQqnUrVQh49YniuC7U5+TMHfrFJdEPGCi2DHWY1bg5OTFw+ztp8zA3I43v8iXFHCE+wqANIzrYTysOeN36nz7FOHVvwIdzWzgej671RxAtgsjkXEdNEKuvuW6Tq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 18:31:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%6]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 18:31:23 +0000
Date:   Wed, 18 Jan 2023 18:31:10 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Avadhut Naik <avadnaik@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        tony.luck@intel.com
Subject: Re: [PATCH v1 3/3] x86/MCE/AMD: Handle reassigned bit definitions
 for CS SMCA
Message-ID: <Y8g67l4GkCEwSOg9@yaz-fattaah>
References: <20230116191102.4226-1-avadnaik@amd.com>
 <20230116191102.4226-4-avadnaik@amd.com>
 <Y8Zo+hj8qxYpZdAl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Zo+hj8qxYpZdAl@gmail.com>
X-ClientProxiedBy: CH2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:610:58::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c646ad3-6f58-46e4-2f82-08daf9823375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXadwKXYDnFciHk0b4Yrk3MJ7JREhFkxt2cYTD+28JgZAD5sbj0OGDgxlEvkeDUduTEi2QVCnWkE85xqLFFeBZTpZ6BFL7zdZr38eLIpr5ka80ppxMuV16ahedls12TEwCmogL0Xs5htdta8aVfkbv9ZlGSOFtSxbNOTto6r4cyOkG0MdnoOQyX/KjmwRnDYUyj1ReebJVRlZF7u4WS74l4yMCKXdyHZsaCv1/VTKHkFGT5JqktAW7dhgbQ5DmEsqVEQwX5aPM3NN/lrm/mNiTfyP7Zmxh8xG6I4z6JeBVa+YhCPnw6wA7l/fWquRsG3Bq1SczyKAglF95FttXS5wPgrJXTxTzZzB6lCS8Yfqyu89QtQFK3GRMccLw0V7fzgie7mJQ87daIlTegAkOsMMUMWhqsdX2FXC02N6KVUY+CWJ7D/uZFwbykzJDxWDv++hVYdt3j9xHnFA1J0zkP/P3pWWt8x9/BarGc7wS1dEBEP2U3fbxwnjmk91VRuaPHf0D4l3m7nSRx760EWZ/RIxCClQ2A4RsdPigyVJ9T6vds31NKgO8bJzxsGoz+tq9RrQwPlH/u4XPOSz1fm2Bl00MPxUP2groWY0gdrr2/N1m7hddtedZ8rBxO20lSLen3lHsomjdWh8De0pd4iMcfRfv3OIkqz+3fR4NdDpFpgOfcDtSNGz5yu0cLYi8tVF3mw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(83380400001)(38100700002)(5660300002)(2906002)(6916009)(86362001)(66476007)(4326008)(66946007)(8676002)(44832011)(66556008)(8936002)(33716001)(478600001)(6506007)(186003)(26005)(9686003)(6512007)(316002)(6486002)(41300700001)(6666004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TItCboSrgWBCnvBcQhNA3l4J3Fa98HfsgZ0qbWLWfspAmVbocP9OChX1PGKa?=
 =?us-ascii?Q?1uwgLc/d7Q23C1SovuyouB2nE1tOa3nueP08vwkBopqSlgaCB+xOX/MoDiN2?=
 =?us-ascii?Q?+mr4qilWI3qzdJLeWEuue84KTgDZto+SEIOkXK8lHgKkyQ+i/edaGnLyTHid?=
 =?us-ascii?Q?wXUuauZ/rHpUcbryd3reY7/cEStqxoosUJFQJ+Hqnc/CfW0MYO6ZluHGZEt4?=
 =?us-ascii?Q?fGgzaAAR77gGpnC/85LuWolWZZyExo8HV6FalONgAUyk7Cp282MPBxujjPuW?=
 =?us-ascii?Q?xTp/HJuEZrrUIQkVkP6l+gZmW6Bh2TYWf/IuLIPX536Wkf/0fE6xkY+1BCvV?=
 =?us-ascii?Q?PA0uRbDuiLFLBb1PdSuQmhUdzrLpYe6+nUJ5mW+DxfVrVCEN21mqLu83AgoU?=
 =?us-ascii?Q?F9R1rX86X/J8RQSs2EIYiAwDFiYTz8gjjo3uwBT7jOTfIw0DXFwODXEC9F02?=
 =?us-ascii?Q?kbNWB7yoF6V5bFymKicBikrqVkh6REfRsaiJloCR7ScYbLIT0cVK+c4Pfn7d?=
 =?us-ascii?Q?Azaf/5GewEKp7O2dVD2euZ0NowxeIkJvDrIrgh0yBewZQFDN7DYxK3phZSGK?=
 =?us-ascii?Q?tpaOMxC9ViqCM488LZHAC17Hk8sJNIbW/wONzdrEsSYFGYPo13xakvKadeOG?=
 =?us-ascii?Q?zg3yfoHz4K1i+XxKgSq5eApG8RXzsMB8+5X1H2d/pRUBeiV6S8sob20tHEry?=
 =?us-ascii?Q?OBAJu5cBy1A57jt7DiDgdI5OrluKigsZD0mcC36xRNxmcS/B5uhU4gPqPpfT?=
 =?us-ascii?Q?4I6olwkA2/vOMTfwqKl+ahXpAnNMKS9sYipsXoRiWFFXxJndPlCtnnMR7NPN?=
 =?us-ascii?Q?hCjkn3vjOKPEy8rplr+AzhZFpZZCeKpTgCAer+2eoU/fXhJ5AfX+cp3/xpZL?=
 =?us-ascii?Q?VvSzcWWSRIDwFFhJajVMtaezFDRLzTZexQo3TQ7Hn3gkwn74EzAdzbUx+SPG?=
 =?us-ascii?Q?wZ+/lTuFkNuhUSPJ658knAzc/TRt26bCoziWCAjCMr5MaIq4QKbTGwG0NkeI?=
 =?us-ascii?Q?O3d83SjrpvAS2mbXOuzrXv1ki9Wc6hxx253omTjoWZ61EBdAIcGr2K/V7klH?=
 =?us-ascii?Q?lp34OGBVh8OwRKisGCFeXW4dpMWavsV6gjP2jw1i0puEEzz3PKJqdaq5jgqM?=
 =?us-ascii?Q?5gN6x2ElHy6fl52/jXAUOwH7aQBn55VzINM2GZ6/423y/0V9kqgjaVmdgcoZ?=
 =?us-ascii?Q?BEPMaFWHrppixWGr4uHZmOVXkiXbUAQns95kdm5lH572oazt63vwF1neY9IX?=
 =?us-ascii?Q?K9Gyv8RbqcrMkVFoeey1wJ7ss66nPDawEE3gLnf/iPqQ1mqKbF8iLcEn8HQ7?=
 =?us-ascii?Q?UNo9QbdK4k0uC0nVoFQyh03AOVnZcXTnCFEjOFJsWITXBhV2Zu9x2vNqqGos?=
 =?us-ascii?Q?2u/D8ZkvJ//2kJq79eb6HhVvPpCvEnTWCSml2Nt4H49dSkTF82thiAA6nTDD?=
 =?us-ascii?Q?Rj0kQd9ar90yM+aFDt9CYZ65OPUAgS1TQPjRslJzOvEKjpMIzYp4tGhfLSmf?=
 =?us-ascii?Q?lTYh5Ezk2FeezrLFKW9KaP60yNcLIxln/m9EHMTv8/MSpM/3W50mn1Gp9Cuy?=
 =?us-ascii?Q?P/wEtPRupzhnD0tX0CU31kBWYmXLERcm57R0dVz9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c646ad3-6f58-46e4-2f82-08daf9823375
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 18:31:23.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiksaGsTV3dbJ6+ucaC486vZkaRlwjpPhaXyIaQRoVz3OG4ZYCdCwzJhHqqqTo69V6903yAXDclsqGEB4e4zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 17, 2023 at 10:23:09AM +0100, Ingo Molnar wrote:
> 
> * Avadhut Naik <avadnaik@amd.com> wrote:
> 
> > @@ -178,6 +178,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
> >  	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
> >  	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
> >  	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
> > +	/* Software defined SMCA bank type to handle erratum 1384*/
> > +	{ SMCA_CS_V2_QUIRK, HWID_MCATYPE(0x0, 0x1)  },
> >  
> >  	/* Unified Memory Controller MCA type */
> >  	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
> > @@ -259,6 +261,17 @@ static inline void fixup_hwid(unsigned int *hwid_mcatype)
> >  
> >  	if (c->x86 == 0x19) {
> >  		switch (c->x86_model) {
> > +		/*
> > +		 * Per Genoa's revision guide, erratum 1384, some SMCA Extended
> > +		 * Error Codes and SMCA Control bits are incorrect for SMCA CS
> > +		 * bank type.
> > +		 */
> > +		case 0x10 ... 0x1F:
> > +		case 0x60 ... 0x7B:
> > +		case 0xA0 ... 0xAF:
> > +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
> > +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
> 
> Why are we open-coding these types?
> 
> Why not use smca_hwid_mcatypes[SMCA_CS_V2], etc.?
> 
> > +			if (*hwid_mcatype == HWID_MCATYPE(0x2E, 0x2))
> > +				*hwid_mcatype = HWID_MCATYPE(0x0, 0x1);
> 
> Ditto.
>

This code runs before matching on a struct with the enums. It seems simplest
to fixup the hardware-provided value before setting things up rather than
changing things later.

Current code flow:
1) Read HWID/McaType values from hardware.
2) Loop through known types and match on the HWID_MCATYPE() tuple.
3) Continue setup based on matched type and its Linux enum.

New code flow:
1) Read HWID/McaType values from hardware.
--> Fixup HWID/McaType values due to any known hardware quirks.
2) Loop through known types and match on the HWID_MCATYPE() tuple.
3) Continue setup based on matched type and its Linux enum.

What do you think?

Also, a further update (maybe you're alluding to?) is get rid of the struct
smca_hwid and just define an enum with "NAME = HWID_MCATYPE(XXX, YYY)".

The struct smca_hwid had another field that was removed, so it seems
unnecessary at the moment.

Thanks,
Yazen
