Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595AD4FF8B0
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiDMONP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiDMONA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 10:13:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5688F5DA61;
        Wed, 13 Apr 2022 07:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhoemd4TwuBgDc1Xwsm0ssuFuPe/G74thydReZ5HqWYDfWKkyC2VWwvovTmLsKCAFghSWTtOilgpFTfXDP3QML+Mu0IO26XYkxhyeVxES4fezyBWouui+VTbcdAapAZDkrTB9JarKhQ0wduN/JDWz1oNAJpxuuzKZ9Oqwg/uKMn7OHBRtVgrXgXMQ0OOIRp7yn8LZ983l7sArfyP8XKz401nV4w/oQunoUvzta1tM2Wp/tWJ53aUjpleO1QeEK4NbkKnuiUPioN8b0J8Iw0tZNduMa1/Cv+5C15xdYzhc3+U2bzi3PPGDIubLvBQlzCe3wmzQgtSTg8qTi/aVk3qMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS9ZLXzjnwaEY/fGpL6xOUzCbaYqYACIkKXobeW0sS0=;
 b=X96I1+ex/J2ISU/Mhw7WsGgpEd12ywqb+iZcnHIg5lJC8otzYfk5tymvXVxM5qbzYS8fFirHZxG480QHBiK3BNh7pMfog+a1A//oEmB/MwBigndZCyv3oQS7rFRrNWXFO6l4yvY/fnidrTUbQuP/103XWgd19mZZBu7nOVp5S7CR+V4JOthtlXXaH6J19aNTmmr+M3+Omf3VL92gA8vsk55jf8gwXbTaTEhJuz5lVDVsomILcnfnAfOQ3Z474KiDxhozjGKcfDTA2iH8bnJYjSn8r+4LKNaCOxSoD3l92BOzvFEfgsKg+9CMvCBN30f7ene3Jumr0QTBTS+0xpHdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS9ZLXzjnwaEY/fGpL6xOUzCbaYqYACIkKXobeW0sS0=;
 b=GqWCO1HHPhiykem1FTB6EPw/0MKzBryUK2ZkIaVCskSfr4NBTCEJ07BZsyjBoAlS2lTI8Dlcl5Pl8rgFs0pvOf+13Eg65PlWy3vU3WQjgoS3qJu/4suwY810SiwNO/NGEjGwSOfTschhWoe9IT/lrTmnrEugG37P3m/29wxitI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 14:10:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:10:34 +0000
Date:   Wed, 13 Apr 2022 14:10:30 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tony Luck <tony.luck@intel.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlakNe012hhErszh@zn.tnic>
X-ClientProxiedBy: CH0PR03CA0326.namprd03.prod.outlook.com
 (2603:10b6:610:118::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f341caa6-4712-4387-6386-08da1d57605a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB538442326C5D604565F4E85AF8EC9@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uJGrQXvcsOtmCvUao5WMmkxNttHx3N76yTzAXv8uRglCUhGO287WeChAa0AbX7A9NKEFhL1LFgkVW0b6kM0QP3XlNVYBoMqoGdksz7SLlSk9J6tecvP7DM0aOXOsEHSY39KfhBLvVxvidS+3FziJxCsYAzDUiBwS7R2EiRDybwe/EJRa+lig1wAV4LSr+4uAs3USr79amUiga387wbXct2S5T0Xb6lD2luA5xeP3SCuz4ImVPW6hqQvtxUsMQFyuOlfZnUP8KFID3XfxquM5bkju6gkwH9xsxUygKE6AeRQUzj8bDhvOHJVupsNJpM/Z6mldUxTFr0RbvdHvB7DQmIWH+4j6g9WSivrj7yzdRkkzd4w6V7aV+DbYAuMt+kd13XNUrGqZyQMxKjb3CZKTx6eR5t/fTOmVaEZk2ZQvb+oktDCi7uvI590ScqqyIlcsTJwboPpTpr/TSKLlI9KAxFs9WNndaw5CRag77sC6eGVB9nUXnnnTB9pEO9S9PtURDto3rNm5KlZmQc4J6nAbDyCFGdmOv/roiversH+nFOLDR/7NfWkOLe6VRCBJ/B9lmg4L/6mlWl44y6ufiFSl7OtDo/KO4y9ZisiaXJMjKBxTfnC2GSreYiKLmGcW5oYzVJkUdz3M4dTSm7TK1Cj3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(6916009)(316002)(8676002)(4326008)(26005)(83380400001)(6512007)(5660300002)(9686003)(86362001)(33716001)(66476007)(66946007)(66556008)(6486002)(54906003)(6506007)(6666004)(44832011)(38100700002)(2906002)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppsf++pAn1A24G93vKWYcg84nrza9JEhCrSSGT046V0Q7+NnHQQft4jpOXhy?=
 =?us-ascii?Q?s8Tv47DBQHXQk6leW1+dWYGRJlkk8z+c+LJzuFyJ+pPgjkoFG8D3WJX49j4V?=
 =?us-ascii?Q?SQ41bqwjyOeYn2xphE9/3dGe4A/yhji3b8fTmKznirWy0Q7tR73U5qugq9mB?=
 =?us-ascii?Q?aSRwFVUWqz5uSVt8nLaeVBbI+jXOzvmallOIw/g1Un0WNlrt55Chjn4jVYnQ?=
 =?us-ascii?Q?NJHNcwWqXO7KpXfCoZva6ml8UHGlTNpF8jbt3qZ1ZLMVCn5P4knE9J0WDki/?=
 =?us-ascii?Q?G48Xn7jprh022dTqKbyXyqNmY6z/E8XaJqtY8RFUJRLTKqh2UkDYIQFIf+H8?=
 =?us-ascii?Q?Hbl5amPqNCvGA3p3n/M6dkCIC4Q6jgm5e7ulmooojt1eKqzFBhwFDU+ccfU9?=
 =?us-ascii?Q?1ThCWtJIElmNJQQn7720MnOMqSqG8sC7Wh0Yy7JbHgqpIFPY73Nu5h4Xto3i?=
 =?us-ascii?Q?mMVaLVNybXvF6prKC6D/VWGjUOKvvmbtiWWb02ILYnPmgkTbt+UaS1PpGd0r?=
 =?us-ascii?Q?VDJkM3ueI9t+22Tz070J8gTVE44wG3aYutQ805B9dULIvlc3VuIVsnuiOoYV?=
 =?us-ascii?Q?jvYL5/xkomXjrHTG0CAo9+OrcUojXzFCWjyc+mcnvJGs3fM3DKyeoyHYF8P3?=
 =?us-ascii?Q?JxxdGQw1fQk232Vj+Xb7yJ+zqi0OkXCcIi25UkIYN0Ku6SwZ5xiyAyHZjsZt?=
 =?us-ascii?Q?Tv2TEwJInjLNncwg/VEhAgfdfnvVBjL61KWZZJ3WmHXy08SRmNlqecwQ7sm/?=
 =?us-ascii?Q?cmM0dpffcNBwadrH07FbY49S1KO1bAOxjpTWN0gYbyemTod/GvqvjvQBDmae?=
 =?us-ascii?Q?yAGZahlxupBVhOYyH4otDcp0tcy/Iuisdkm78eJYaYwzn0pJ3rTaOlt1Zlwl?=
 =?us-ascii?Q?EuwcSVAtUpdICWJxUkLohXQjvTR2vRkqRDVtKOMjYL3jtTycM+W12Dn5joXS?=
 =?us-ascii?Q?iMoqIF0r1VXaMjPubfBVxoUg3g9k1jkKoW2/kJPCFJXXY6ibKd1wkuGRAEUY?=
 =?us-ascii?Q?mYW9368IAH9tp1929RP1liJEoN9m4ig7wXGzrzMD7ZA8o+SP/B4woOJtqF/9?=
 =?us-ascii?Q?+aWhJ0/J3KIEpE1cWEfNhCDs2Ua1wPSk9zMFRI5aUBTgHTwCcPe+hiIxLhW+?=
 =?us-ascii?Q?YBbxYQfa9tviE9SSvhHtOFTYKUc4TdhDTw812PTnv3FI+54Iy5JCh0S4toX4?=
 =?us-ascii?Q?DjQcdS6YG5l92FOv/RiYZre6rBUDGWKn9dh28ZBgHHsJk/F5YuAeUA4/+RWf?=
 =?us-ascii?Q?0ATWmB0LzRZdHhgsePfM/AKq8YzPHh/6j5Ff3EkA8q7rwzfwGtk689I6R0Qx?=
 =?us-ascii?Q?TwYT1FLnqjV9f7r3b5Mtr5/EMhwTGCJYMHwGn/meVicGRcPcXNvJd5JTPbKO?=
 =?us-ascii?Q?k2fAPw3vJIwaAPLiffwVXAzIrULXTyMoJ9V+t71pBCmKqmrCkQWt1UTs3IAH?=
 =?us-ascii?Q?5CgYkHMxF4C8xJdpoK3MG2ifFvDbYSKa2XofzY5lFnxUN9UwsB+0kBC/mk61?=
 =?us-ascii?Q?/hRPnuWuFunrrS3p3OP9pojzqlILGZrDv9EoHI5uD3acqSvFjQjLWEr1E9d5?=
 =?us-ascii?Q?fehgznpmD4rmeFDod/6YTL+tCp+mZ2ocnF9Q5gNUCqf5rdNfHlVbwOZ5Wsmq?=
 =?us-ascii?Q?AZxOLi5AdE4d8j81fIeEmhwMsEk+YqEN4t6ByNCPLh3WgsmBtc2u++L70Jwi?=
 =?us-ascii?Q?S5CdvSAzUpbFVTY97RcKCek0ctBm5pNnH7zxc+aQYpGq+SKPvaT/0hsn5rKM?=
 =?us-ascii?Q?oP+J+7dVnQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f341caa6-4712-4387-6386-08da1d57605a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:10:34.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AKXccILrToA87t1JFHQh9Fxq+50qXTP6oQGGZWkYvHpHBqCX3S3hgNxJ7mLSmhq8vS4sqR8PDvjtWBs4XbO/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 12:21:41PM +0200, Borislav Petkov wrote:
> On Tue, Apr 12, 2022 at 10:40:38AM -0500, Smita Koralahalli wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index f809eacac523..4f2744324d9b 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -722,6 +722,17 @@ bool amd_mce_is_memory_error(struct mce *m)
> >  	return m->bank == 4 && xec == 0x8;
> >  }
> >  
> > +void smca_feature_init(void)
> > +{
> > +	unsigned int bank;
> > +	u64 mca_cfg;
> > +
> > +	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
> > +		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
> > +		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
> > +	}
> > +}
> 
> We have smca_configure() for SMCA banks init and there it even reads
> MCx_CONFIG.
> 
> Do you guys not see this?
> 
> Or integrating new stuff into the existing code doesn't really matter -
> just bolt it on wherever it works?!
>

This function gets called from __mcheck_cpu_init_early() so that the info is
available before the MCA banks are polled in __mcheck_cpu_init_generic().

Maybe we can avoid some confusion by renaming this new function? It doesn't do
any feature initialization, so maybe smca_feature_detect_early() would be
better? The goal is to get just enough info that's needed before the bulk of
generic and vendor MCA initiliazation happens.

Or do you recommend unifying this with smca_configure()?

Thanks,
Yazen
