Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC024E9CD2
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiC1QtR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbiC1QtM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:49:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD164BEC
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjOpVA0rQkS4wRjjO1s+Zgy28KbP4oFsZO0BleNfsfjWOn2Yx2gGicoDPWwTb7TUg7EgawxCTr57Z+3w0/qSWwKvhpTvQWuS24VM/QUyQrppbXJE4DQ7UfhCSrP5FsujT8F+phIfAh4ST6SiXaVq+Bq2kBrlu3YEdC4jSrgWx71gwENZESzuXfE7+5rTDazH1rt5NRkQHBkynBSlItWuDjz82CgmajiEHTznug+1r9GBvKh4WW6rVt6IiMJ+R072auqSjTWifI6SqpjRrXbNjnpDJEUgE1FrTKti5QWbHOJWPP/KFV+xfBaxyFIaoWy+dJ2PWzol7vMHn2p0yRvoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQLP2xBjZO+BKwc/VZN61EmCghxJkCdIo91zZzV3Z/g=;
 b=jjokuqOQ2C0ZlGy+XGLLPU21b9hM6yv8sZeCS7ozgBLq65xaE6Y71GiH73RYKF+kwDNhc73kKWEpBzGjXfzdpj5daxxWOMYRJQSVArUuc4MFDT+9GI3v9zt4QaWvZphCtszQC0/ufCSrZsZpZw04n69M0SWu5m/aI57klaKxgB+WpEosvLIcj55e+7FLaTUmcC7LE3iUu0ApZWvEExh2Atp203Pp9vEXvfFjBT10JnFhPKSsKYByJm3GzDNuhTZbfoNAEeAk+ZSTVOmSDQhh5mL8gBadeDYyYIxG7LwGjwq/I305pung6++ZxQ2JsZkkk3ZcxXao4vGbZWiRCcLnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQLP2xBjZO+BKwc/VZN61EmCghxJkCdIo91zZzV3Z/g=;
 b=4jUwb5EM/NQqpJ7gllLeHTC33ZED2fHxCr31XSRLoVUbJS2QcugruH5X5KAWIc5yzdzpFsJUk4cDHsGYdMSMGF4xcLgGWA0J+3BfsTOfV7AQvkXMKtJS092SUsTuRI5zi0rCKw+30Qr0YECnWrlpEDidWU8VYy8Ds53n4EH6WSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 16:47:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:47:11 +0000
Date:   Mon, 28 Mar 2022 16:47:08 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 11/14] EDAC/amd64: Add populate_csrows() into pvt->ops
Message-ID: <YkHmjDJZebLI1Jdy@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-12-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-12-nchatrad@amd.com>
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04bf5ced-6ef4-4979-ed97-08da10da9aca
X-MS-TrafficTypeDiagnostic: PH7PR12MB5903:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5903441F6617DE8444EE5A50F81D9@PH7PR12MB5903.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcF6sE3YC2aiE7XZ2H/dwgH4JVMUBXIn2RVzdgrqMoa4VGJQrNNpJ6WHZHf9AW0GZj2HQWvr3vYiHreiRNo4WW23qj9he61xgxW2KJgRtvwL90SaJdlpjNZPnychH896+svRVe6DivzXZn4JwATUmzbxH/kUAYXAI85SgkoAbJKR9hpBnbIJ5mE/tIkZYbaPaqIsYDim/lUSeYcVmJEqhsGHr1ym1TkpjLaurNC5Yc+6oayNcD07KPAaMguJ6IJSgvnx2IROjkSLBj2tSo2BMq6npSlsf7Yt1HxvM/ZuApjvK47FhD5ooLoxJnon+ADWGnT4lkia2UVLz1BOmV91+LvOHCtVxx7WMB3SVtfAYoUecOblaKFl+TTuJ7g9mEtkhI3XXLtvTkknEwh1vjkuQyE2idbUA2tuM/xGQnYMN5j4vjrj+0zgiXldgq7beSG2hP0wegPp8YYV1LyW0V66x3DrZVeNeYYWFHQppZ4GJLpVAiRkDtQPjw1tZUdscgNe1SNs2w44937BHaWwLdv4FIiPOPXGH9Ax+6ubCe9s1HQJcbpaSXAD3eY2lztBnWMZ/5Suap6im+OoGwNvM52cs1+TM8TqXHzAXp2gIxCNvqxxLK0COkaVqQg72v6MAiKC44BcnNHm2DvowpUWkvbi4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(38100700002)(33716001)(6666004)(4744005)(6636002)(6486002)(508600001)(316002)(44832011)(5660300002)(6506007)(186003)(66946007)(26005)(8936002)(86362001)(2906002)(66556008)(66476007)(8676002)(6862004)(4326008)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRcjaCKSfalehFE+aCZw442+qC+St4LEJAyHKhekQ7UFj9mLZE1qPJcH9SUe?=
 =?us-ascii?Q?VSAQcOfTCRZUmlbZe1FXWzCvBIzDrlODDZGbveWFTZbgfir5Pq7SjYW+4YHG?=
 =?us-ascii?Q?JwfzfdAkflHztJwyg5H/VxjXY3HS5/AJMnDb6kEVm45W7EoduqFG6OmkFsNw?=
 =?us-ascii?Q?z1i/MpnW0KRompDIHLbTcpAzm0cE9431Kfcse92eXibaSrQIohqLCLBnufbK?=
 =?us-ascii?Q?yQ04p7/AJp21xJVzsQEk7KBDnF64gDoHe/GNPwX0bIDkL3POp9pvLIS5A2y9?=
 =?us-ascii?Q?/VaFuT3dGN2VcPdwusd9B8S40kzlMSWJtKUofPNahpbmTQirAn7Mcn+ptZY9?=
 =?us-ascii?Q?rL+eAp+cAtzKNHGkzGwaUzbHyBVLVOm1A7mSioAsiLdODTDcghtja4WMc87g?=
 =?us-ascii?Q?zCPUMUxZgqmxNpKDEE6koY/YTmSUnM08RErmWhtCcNnSMYzmnfG3n4Snp0+Y?=
 =?us-ascii?Q?W5XKNUpUvlnSMXGN7+LuZ3tgOcP28UhovSdy2lwSlju75iILOfv1gIknad5m?=
 =?us-ascii?Q?hI2CRBLEbkAML7+XgnMwFFOhwaxs5Zyu9LFIMvataNOtOmvlb98fAhyfzWpV?=
 =?us-ascii?Q?Gsy+j2h7JAPHK6YDTrvKtlozQE8GIa+1tzJce3gCfRDmK3Wwr4bZUCdx0Lrq?=
 =?us-ascii?Q?hYlUaw8MCTfuz0AkQSJNq9rG+/mMh+YUHlrIu/ydkF/8Rs9PT2L7RveY8Wxy?=
 =?us-ascii?Q?a0r7rdtK9CbniaDcMu8/lvq0qJmELnXSZvBqUsQgJXueaF/Dgo11I2wh/8iA?=
 =?us-ascii?Q?wpMbngFlYD3lticXHbA1fJPlpr7qN4nOjZHtOjceRiRtCM2kuaopwP/aHceO?=
 =?us-ascii?Q?3Fgrdz1g1x/+bGN8hzkq9swyazT0QPkhIGYJK1vrKcrRlQd/5XQIr6MBA00P?=
 =?us-ascii?Q?TkJktNMdy9TuCLMmt6fH3Mh9gKdjdCZ/XZnX60mrc7GGe4X2NVqlgxQ9h4yl?=
 =?us-ascii?Q?Fv84c2O0SAivE/Uv2VXMZ3Zv0MO9seffCOugxJuRF50r0iuwWOBeeasGlx7B?=
 =?us-ascii?Q?WlN6mwAhML2oJ/O++qUkyjup31r7BPCiOZ3wPCo7MH4ujmEOKYgtmbbmB58O?=
 =?us-ascii?Q?nN/w+eOP+BKzWtglkd7RoEcfJ6XmdjYpQ62pqmMB3tz5qapOlOLi8kGaPOqY?=
 =?us-ascii?Q?qPqt16lS7ubO3236w8rBzyRFTgMqYB7RnuPtfhkbF1nlLdbsmByetUE5zNK1?=
 =?us-ascii?Q?ry2sQMTf4SgP7hStpJSbB9t1GBWGpP9cOWYRZHgsIlR3K4Zy6l+Gk+YgzoGa?=
 =?us-ascii?Q?QOE9Wv99XztguwchT/EyiGZKFZg2vjdKYTowCDND9ldheWrt/hgoYQ01l+Jz?=
 =?us-ascii?Q?EJ/1hboAh1jRqBTqvkdaXS3MYXSdei9JoGTEeW9y4XqXHq+cHZ3r8R42jDVn?=
 =?us-ascii?Q?QckDktDu4CXK4n4ICUgkyc/WqnQW/Ru710+wC1xbyrcIYjzDcRK8n4YTc5dv?=
 =?us-ascii?Q?4N2hJRgtet1T+R1vak6gwnad6adMlppozVQItJFyIXIxkINF++LFZDHGQExg?=
 =?us-ascii?Q?OMkrFpolxtpO6sJDdNKkR4txdff8wFc5iZi1Vh/r+VAjNjY2WeiMsQEf7ihL?=
 =?us-ascii?Q?LwBKKDZ7gPLsSa4OOLtSwAfciKk6p4ufTfcJ4FJ0wS2qseG3+mx865wBKL/x?=
 =?us-ascii?Q?jPQtVvtCIUpx1NWRk8dR+/zFYQ5NwPcdbtIItUjwxrQQVHn6b8N2Rf5VkFbw?=
 =?us-ascii?Q?mHma1y9zUrhVYm8k65US7kGIjTV3CUq8E0HCXuOz1nqhn0qU9viwzU2eVn6E?=
 =?us-ascii?Q?ndUcIsYO0w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bf5ced-6ef4-4979-ed97-08da10da9aca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:47:11.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13d5EGWK3nSKHA0q7aR6UWsggHcn+1l70I9pSSnGVxFUFTMsDztS4a23NbrxdXrTP/DjLPAiysC/vVqlQyjB3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:51PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for populate_csrows() in pvt->ops and assign
> family specific populate_csrows() definitions appropriately
>

Please include the "why", but otherwise looks okay.

Thanks,
Yazen 
