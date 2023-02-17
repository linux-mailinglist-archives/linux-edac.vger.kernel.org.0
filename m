Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1BC69ADB1
	for <lists+linux-edac@lfdr.de>; Fri, 17 Feb 2023 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBQOPD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Feb 2023 09:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBQOO5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Feb 2023 09:14:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD9474CB;
        Fri, 17 Feb 2023 06:14:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hx6m003591;
        Fri, 17 Feb 2023 14:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8BSVU/lh14JvPb4MaBQg/1SLhOj4iLcZfFU0WZgbJHs=;
 b=Jfb2TPsZnd2gaC0L0qYUWJZX1PW3ZOmTYnpdhgbKBrph5fBZkzmbPcrL2OyBqkH7Kb6B
 5tL/nauiAKae7D7jAJ/fYskPUdwJPAiWlFaZKmV9lbrC1bV6N/YV6NxyOggvjPFrqyKZ
 kQxhFhku+J96fjpP0nWWaSRhIuDUaF7ka8i5KXuyomacabw3JCXcwOXYYfIs+3hCs5FN
 DI5P1BZsw49j6TKi7Sy4v2j/WdMIG94Gf8d3XqwJZmK/n5IQ4/1UoCe9Hgcmw9qodNHV
 21fWiqnSGMnzJqgKqBwerDueinuJpdp6ObJoA92ZaqSgEJc7Y3/FQOBxzdCoIVc5RNvb qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju5ybt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:13:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCxSo3020169;
        Fri, 17 Feb 2023 14:13:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fappk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMnpS71G7h4QYrZ5eIZM9aZNMYyMxiECutPuGfB+yeMJ1rD6/XKPQaE1yMXmZWLkrQKE/bsdsz1nRBoLLaiFjSHB2Z4KwCmioGXF42xb516Dy7csqLQ9yv2FxOwJCSxtCX+TM7OyQVWklMhc44ktwRteHcaqonNSZb/rt+f/zItE8MFgmbejOImXfUJHYOZJYf4ctn+B8cWPfmBlH50xVBmeNCu7wgfVV0l6wHIrrUcUPUpVpZE6vNgon7AF0rgJrVax6eipCsM4sSDiVQdnAX0/+vVHM66INupwARxhZPCu2W/YksZXjVl+UgGjIjXs7VWn4xd+7Leqd+i8CmNw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BSVU/lh14JvPb4MaBQg/1SLhOj4iLcZfFU0WZgbJHs=;
 b=YuWrRw54jmxepba7aKRNNB/2+BrQ9yTebvpuOGuR+bFdC4WuuN5jQojBAFG7zs6Y+Jc6opcSNIRdgN5dtUGxKfs25VfSl28iB3TNvjFrYz8wqLAP8gOSkkqBLSJpt47hyo/i3TY9sj5mRbaMP2PS4pVB87g871Van+viat8swHKCCyyT035mebivYJbdsvSSr4ozxnpbFqFEIJTXF6+80i7PPXmKUPyu05/EDC2GixIfPWVRY8M6R0A05XzwEM3FK1SdzwcWg9/7tQGnchVGYs3bDis2rfiAgbn67dcR9lWxwEE7TvtuXU0fUuc8NI4mpu97rGk1OfhpmHbrdUie7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BSVU/lh14JvPb4MaBQg/1SLhOj4iLcZfFU0WZgbJHs=;
 b=XgKTONZV1q610FiHmhu1zSr15dw5qt9EmPlTDJy4f66eW0AxSLOngG5K4igtSdrLfZD92mmLTtSabm3Ew/KU0EjYAsnY//Iqyl7eBBAI53gpcdQoJ30GLMLVnrkH5vBmOTXUjx0v28Tu6pbNGa+sFXbrdS4JYl+YOOKe9Hsrshs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:12:58 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org
Subject: [PATCH 23/24] kbuild, EDAC, altera: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:58 +0000
Message-Id: <20230217141059.392471-24-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: c81f35b9-fa43-4c82-2fca-08db10f11213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCSFSPJ/TY/v7v2VhNCA8sEWz8sCUWbfuT19wBGBX/GdSRp+jTXQLMGVYLwC00yZ+VY+CZZ5KjFmndV2T9OkYy5u9NupnNLzhJVcOLhzV2VFPpqiduCO2XAvxHpUMCPPs/vxtiiDIs05Hg/AzzdphJyqmcDaY1Ij6FRUyCBU+e0ISV9hb7vPalusWICRg/JlRAmfHlQf0hyeWq6MeA7kYCVa0+J6JMY1jk9BWZSYAY+fgL4PWJpx+UqRX+6FfmKqhseLK6O2M8EusxSQfBp61esyTO67JkfDZTUTdZgR9ksF6BHCmAtAUgqANdjqRYo8Wx/ahxE+6GRqEVFvR3HUYXQBjWTPoci7jf7xjBjQ6HZh40I99WxCpIewS6CPgmZKgPKAf0EFy8+zYlOEmKgKj+CyBtFQpoi80zlERSNuj+0HqNE9NXQm3ZZuMS25fkflKr4CW0b1TT7h2kxGJoMcmTnyOG4h8qWF4wSjNx166lS+Nqv5MIjt82J0Mp5Gl0Het2EaIIz+cU8gDMcEaVNExygL2KqF0c4I3lrSbuwTt3u5gyxOKZDKBNd9VPk2HLl3F0lVj0RLFFnRJRMVOZ6NsX4VaQCnFpNiCosXxSzYLyKFRfZEAuXY9t6xRXitw3eNmKsUpjDh5X+cWotGCeoIMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199018)(38100700002)(2906002)(36756003)(6512007)(2616005)(478600001)(186003)(86362001)(1076003)(6506007)(6486002)(83380400001)(44832011)(41300700001)(8936002)(6916009)(5660300002)(4326008)(66946007)(316002)(66476007)(66556008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CChWRFvatxv2cxbxddgqa4M6JdGH21kNPLIUDmIxGJGUlsdmmMoEEpG75cBh?=
 =?us-ascii?Q?MbQZ5Sap2s2pDZQ9tTY4Ez3RV7gGs9gTvDxtgiHafEKGb3sKJm4HKZnoaOWu?=
 =?us-ascii?Q?qFo56sicWTdUQRlekxyPZdso9B6OIIP4IdpTEUK3V9bc4XfhExbwcW9bPBtQ?=
 =?us-ascii?Q?tsAX8Gt9kz/ewalUiX/gOlRSHPNL8kla1bqMEFnv6YeZjbKclIufSK5TTwT+?=
 =?us-ascii?Q?RVN2bpBdnAvZ6bG7m4syghtqloL6N3gRcbFMnrKWQJV+EYH/VckDmCl8avMB?=
 =?us-ascii?Q?swucvRvmzfdQKx6DEk/s0UaqIUhZQmX2MBMObl8Jv0y+0mG93pFrJ20qW38/?=
 =?us-ascii?Q?XMnvMUqrWtAmIPvW755YJZiyZKsWJ9mUVBfmtKsGPmn9RnKmmBwBjsvWcAPY?=
 =?us-ascii?Q?5BuUXLJduLRUMPZcFtKjymfJAspfDMGQeFyVjYuMJu6rD/sLu/izfcit7Jt9?=
 =?us-ascii?Q?7MMy8oPB4bNRAZgs0GQx4Hkuh/k2dJm25ANiMcmeozNskLJeZSdE7Y2ISK3S?=
 =?us-ascii?Q?J5zPfoiCmeavkFIH7aGaLQl/xTd/IoY5stsiwTRtzKOp4f5eO7Qi7WKrNqnf?=
 =?us-ascii?Q?6dyZjfvqGx6jRkhKv4VJjyKgSwkGx+h8KC6ZMQqUwWzRY/Czs52c84UUU5T5?=
 =?us-ascii?Q?z6IebKySDo6jTxRvLunWn2Xfu3C/T+kvrgvOP72tj/DSxSCw5tDjcQB+3BR0?=
 =?us-ascii?Q?U4ohVxMUhKSLkNhwHjcJTQNyk/OMUwGod6fegVs+2FVjB0/uGDoK8ZBNNctq?=
 =?us-ascii?Q?awXyvp8WykJ/PGHQ0vqsHX46zJS7kgfnyqP2PsFeRF5FRuf82UU31m+jId6Y?=
 =?us-ascii?Q?Bm3u88njO4L5yH5GNwsaQyw2CP0yX4hKlkqN/5JWtPhGdbm3z3vHbxc+T+jt?=
 =?us-ascii?Q?JmwSLFxplUY6IU8MgV+rnE9xr6yKim1thcGKmS/XFeee/UF0VdCFc/YDCxwU?=
 =?us-ascii?Q?yGdi5Bhps30NPg0Hk2ZIpnGARu2aGt6aK+7e8RCHrYx1SS9VEgUTvlUcdis0?=
 =?us-ascii?Q?ou30lG6Klw3Ay7LRV9w6sKS34e/hikr02UgSUrgYbWTR51e9B+I2m8xD+Yi6?=
 =?us-ascii?Q?UuH9Aw07W/JDaH798qdOc/R1dIclA9PJ3Y2aCoG30og5g2kLCUyJJkHWnrhz?=
 =?us-ascii?Q?Bll9GOubVdYXXYI/ThdqlffzARpFATxezVhkfUxSzoPqJ3KdUmw74OEQE4HQ?=
 =?us-ascii?Q?l1MXDsm6ecCGD7u3j6/gWTJteVa3C9wbwdO8Do+vzxJFEb7yrMp0EMWp8qtP?=
 =?us-ascii?Q?AmeejmKCK9CsTuOm13D8oTblJVzvVKLglEA6lJ20mXGCToKwtk1EWDjS1vGN?=
 =?us-ascii?Q?7EG88B/vAD/PklGY/jDE2txpe3dlPbFsZOhW03NaGvnLgtAll74kLrYIlZZL?=
 =?us-ascii?Q?+rlCZX6g6p5qNyjW9VLOsdQvHQub42fvueas9u21PcSq1TUUp1/KyCcfPo84?=
 =?us-ascii?Q?gtU4vNnryqhBnD7MhkWqvTVTh0DiMbVi8VFVpgUZcH3vU+GuW7dTLjlKWUKd?=
 =?us-ascii?Q?nDh8sJUROhKPsRxGwYg21bQyjS+EDruVCgxXvQsO/oW4EmikYONDg1J4cFs5?=
 =?us-ascii?Q?TgcASlyOuD5dIfT/WbYOemlNGIldUXyHH4DGL3WFnP6PSpBq5wguDi3QM9jg?=
 =?us-ascii?Q?wkgJxuSJrr0IVEcweNSwyQM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5t7Pt7+CVcfj2Z7qXJ39pbdcbOg/moAuqbL4d8NR/dRV3ONJAG/T7X12lgcAqDXtBATxUyndZ7OvEwBwgrai+wnk7X79iQm5X11pu0nCg16eIXBA4puu6nY03oR/K6Yz963B5Gd0W0WtaBavmO27km3KTXTH+MQIXYtk9Csw0AUfzJKnpt0Nh5lwmcUoOawHLdFg3xzfzhKjlwsI1eT1N/iKuc3LZWSz1G9HNgp8VkaOquiQ/HPbRTRskNFVV0WUcvuV1G6Pg3YaLyCKCUuyqKbdo6SQxR0eUSbX/RnyKWOZfvflddzlMvqbH44WaTnB1q46OGj+Y5taFWsxTyfH7EZAQ7YQE2ubdqoTWBAMNls7d5Qsujf4iXsnFZHxvLAE/6KAq20obUHHRmurGpHoDejdqkOjIB/4zWd9z09OyiOz/XcQmdD3QAQTtT3gqiXhUZQGhmAB+hrQBWDV8M20CURRfCxHzIs/iQEt6bbdXsOojA8aTiPBsdEmefi4p34VZwu7sa9UIYXN2ZMjc8mSUtLEXzI1YP10ucSv4fisfRTeyLQmjkgR6DRg5a4qnwE8YvGRlKtqU4s5S2EhZnNfzPd81xVIwv4jSHddv4Jv/6WGEAsV64YquFJce1tkoNXMTL6t6sCa+OyZJcskDOzHxt44xKMgudnwVvR2UDVLyM+E+e3oQBHl6Ryfx55l6ejuEV2v4qGZqvmqdat48ffNeSHqrO27Lmg9+EY5TVk6HLhvWGDVqAeF/oSWfKK0F4/wxHLZ0KHfpmTztnEztD0shHImJYCJNXXzoGFZrWbyiHt2YJy1I53OcHxHEuRENRWIxZIxNPAGh9GT9ZypSSIM0eC6ePXT0izXTtk696AnZPw57c9G5TW0k7wUXQVPciAW
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81f35b9-fa43-4c82-2fca-08db10f11213
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:58.1967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6bTQfaNJgFxgjNolKTK4OXJftnuwqmR3EI2pdcsbdkEdPzH8oN/qRRtVCVR+jXUdSUzmGAGgNofha4jB4lL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: 3vmVQsJ5Wv7lVnofnylIRIapKcTAkDyD
X-Proofpoint-GUID: 3vmVQsJ5Wv7lVnofnylIRIapKcTAkDyD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/altera_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..ba325d4c5e83 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2226,6 +2226,5 @@ static struct platform_driver altr_edac_a10_driver = {
 };
 module_platform_driver(altr_edac_a10_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Thor Thayer");
 MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
-- 
2.39.1.268.g9de2f9a303

